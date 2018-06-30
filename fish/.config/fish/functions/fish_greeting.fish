function fish_greeting
    if type -q cowsay; and type -q fortune; and type -q lolcat
        fortune | cowsay -f satanic | lolcat
    end
end
