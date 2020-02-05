call autoformat#enable('python3 -m yapf')
try
    BracelessEnable +indent +fold
catch
    echom 'could not initialize braceless'
endtry
