P = function(v)
    print(vim.inspect(v))
    return v
end

RELOAD = function(...)
    local ok, reload = pcall(require, "plenary.reload")
    if ok then
        return reload.reload_module(...)
    end
    return ...
end

R = function(name)
    RELOAD(name)
    return require(name)
end
