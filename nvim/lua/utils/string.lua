-- split string into array of lines
local function split_lines(str)
    local lines = {}
    for line in str:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end
    return lines
end

-- turn a camelCase string into snake_case
local function camel2snake(str)
    return str:gsub('%f[^%l]%u','_%1'):gsub('%f[^%a]%d','_%1'):gsub('%f[^%d]%a','_%1'):gsub('(%u)(%u%l)','%1_%2'):lower()
end

return {
    split_lines = split_lines,
    camel2snake = camel2snake,
}
