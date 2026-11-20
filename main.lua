local mp = require "mp"
local utils = require "mp.utils"
local msg = require "mp.msg"

local SCRIPT = utils.join_path(
    mp.get_script_directory(),
    "multi-audio.lua"
)

local enabled = false
local saved = {}
local bindings = {}
local events = {}
local observers = {}
local timers = {}

local old_lavfi = nil
local original_aid = nil

local function cleanup()
    -- 1. Удаляем горячие клавиши
    for _, name in ipairs(bindings) do
        pcall(mp.remove_key_binding, name)
    end

    -- 2. Отписываем события
    for _, callback in ipairs(events) do
        pcall(mp.unregister_event, callback)
    end

    -- 3. Удаляем наблюдателей свойств
    for _, callback in ipairs(observers) do
        pcall(mp.unobserve_property, callback)
    end

    -- 4. Останавливаем таймеры
    for _, timer in ipairs(timers) do
        pcall(function() timer:kill() end)
    end

    mp.osd_message("", 0)

    -- 5. Восстанавливаем аудиограф
    pcall(mp.set_property, "lavfi-complex", old_lavfi or "")

    -- 6. Явно восстанавливаем исходный aid (до audio-reload!)
    if original_aid then
        pcall(mp.set_property_number, "aid", original_aid)
    end

    -- 7. Принудительно перестраиваем аудиоцепочку
    pcall(mp.commandv, "ao-reload")
    pcall(mp.commandv, "audio-reload")

    -- 8. Страховка: через 0.3 сек ещё раз выставим aid и повторим reload,
    --    используя "сырой" mp.add_timeout (не сохраняется в timers,
    --    поэтому не будет убит при повторном cleanup).
    if original_aid then
        local aid_local = original_aid
        mp.add_timeout(0.3, function()
            if not enabled then
                pcall(mp.set_property_number, "aid", aid_local)
                pcall(mp.commandv, "ao-reload")
            end
        end)
    end

    -- 9. Восстанавливаем API
    for name, fn in pairs(saved) do
        mp[name] = fn
    end

    bindings = {}
    events = {}
    observers = {}
    timers = {}
    saved = {}

    original_aid = nil
    old_lavfi = nil
    enabled = false
end

local function start()
    if enabled then return end

    -- Сохраняем состояние ДО загрузки оригинального скрипта
    original_aid = mp.get_property_number("aid")
    old_lavfi = mp.get_property("lavfi-complex")

    local chunk, err = loadfile(SCRIPT)

    if not chunk then
        msg.error("Cannot load multi-audio: " .. tostring(err))
        mp.osd_message("Multi-audio: LOAD ERROR", 3)
        original_aid = nil
        old_lavfi = nil
        return
    end

    enabled = true

    -- Перехват горячих клавиш
    saved.add_key_binding = mp.add_key_binding

    mp.add_key_binding = function(key, name, ...)
        if name then
            table.insert(bindings, name)
        end

        return saved.add_key_binding(key, name, ...)
    end

    -- Перехват событий
    saved.register_event = mp.register_event

    mp.register_event = function(name, callback)
        table.insert(events, callback)
        return saved.register_event(name, callback)
    end

    -- Перехват наблюдателей свойств
    saved.observe_property = mp.observe_property

    mp.observe_property = function(name, typ, callback)
        table.insert(observers, callback)
        return saved.observe_property(name, typ, callback)
    end

    -- Перехват таймеров
    saved.add_timeout = mp.add_timeout

    mp.add_timeout = function(...)
        local timer = saved.add_timeout(...)
        table.insert(timers, timer)
        return timer
    end

    local ok, result = pcall(chunk)

    if not ok then
        msg.error("Multi-audio error: " .. tostring(result))
        cleanup()
        mp.osd_message("Multi-audio: ERROR", 3)
        return
    end

    mp.osd_message("Multi-audio: ON", 2)
    msg.info("Multi-audio enabled")
end

local function stop()
    if not enabled then return end

    cleanup()

    mp.osd_message("Multi-audio: OFF", 2)
    msg.info("Multi-audio disabled")
end

local function toggle()
    if enabled then
        stop()
    else
        start()
    end
end

mp.add_key_binding("KP0", "multi-audio-toggle", toggle)

msg.info("Multi-audio controller loaded (KP0)")