local node_msg = function(text)
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

return {
    node_msg = node_msg,
}
