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

return M
