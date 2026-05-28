vim.api.nvim_create_autocmd({'BufWritePre', 'FileWritePre'}, {
    pattern = {'*.c', '*.h'},
    callback = function(ev)
    vim.api.nvim_buf_set_lines(
        0,
        3,
        4,
        false,
        { '//! Last modified ' .. os.date('%d-%b-%Y.'), }
    )
    end
})

vim.api.nvim_create_autocmd({'BufWritePost'}, {
    pattern = {'*.c', '*.h'},
    command = '!astyle %',
})

vim.api.nvim_create_autocmd({'BufNewFile'}, {
    pattern = {'*.c', '*.h'},
    callback = function(ev)
    vim.api.nvim_buf_set_lines(
        0,
        0,
        7,
        false,
        { '//! @todo add a single-line description for this file.',
        '//!',
        '//! Copyright (c) ' .. os.date('%Y') .. ' Beckett Thermal Solutions. All Rights Reserved.',
        '//! Last modified @todo date is auto-completed by nvim on save.',
        '//!',
        '',
        '', }
    )
    end
})
