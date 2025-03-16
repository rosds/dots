local neogen = require("neogen")

neogen.setup({
    snippet_engine = "luasnip",
    languages = {
        ['cpp.doxygen'] = require('neogen.configurations.cpp')
    }
})
