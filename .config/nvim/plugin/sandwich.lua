map('<leader>wa', '<Plug>(operator-sandwich-add)', {noremap = false})

map('<leader>wd',
    '<Plug>(operator-sandwich-delete)<Plug>(textobj-sandwich-query-a)',
    {noremap = false})

map('<leader>wr',
    '<Plug>(operator-sandwich-replace)<Plug>(textobj-sandwich-query-a)',
    {noremap = false})

omap('ib', '<Plug>(textobj-sandwich-auto-i)', {noremap = false})
omap('ab', '<Plug>(textobj-sandwich-auto-a)', {noremap = false})
omap('is', '<Plug>(textobj-sandwich-query-i)', {noremap = false})
omap('as', '<Plug>(textobj-sandwich-query-a)', {noremap = false})

