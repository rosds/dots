local M = {}

M.node_msg = function(text)
    return {
        node_ext_opts = {
            active = {
                virt_text = {{
                    text, "GruvboxYellow"
                }}
            }
        }
    }
end

M.camel2snake = function(str)
    return str:gsub('%f[^%l]%u','_%1'):gsub('%f[^%a]%d','_%1'):gsub('%f[^%d]%a','_%1'):gsub('(%u)(%u%l)','%1_%2'):lower()
end

return M
