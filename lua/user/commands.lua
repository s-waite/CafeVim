vim.api.nvim_create_user_command('InsCharToCol',
  function(args)
    assert(#args.fargs == 2, "Incorrect number of arguments, please enter arguments in the format \"InsertCharToColumn [char] [columnNum]\"")
    local char = args.fargs[1]
    local column = args.fargs[2]

    -- Insert multiples of the character
    vim.api.nvim_put({ string.rep(char, column)}, 'c', false, false)

    -- Delete any extra characters that go over the column limit
    vim.cmd('normal! ' .. column .. '|')
    vim.cmd('normal! d$')
  end,
  { nargs = '*' })
