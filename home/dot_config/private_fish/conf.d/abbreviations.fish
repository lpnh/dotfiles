# function to edit the abbreviations file without warnings
function abbred --description 'edit conf.d/abbreviations.fish'
    $EDITOR ~/.config/fish/conf.d/abbreviations.fish

    fish --no-execute ~/.config/fish/conf.d/abbreviations.fish
    and source ~/.config/fish/conf.d/abbreviations.fish

    if test $status -eq 0
        set_color blue --bold && echo -n 'SUCCESS: ' && set_color normal
        echo "~/.config/fish/conf.d/abbreviations.fish sourced"
    else
        set_color red --bold && echo -n 'ERROR: ' && set_color normal
        echo "~/.config/fish/conf.d/abbreviations.fish not sourced"
    end
end

# yay
abbr yi 'yay -Qi'
abbr yl 'yay -Ql'
abbr yr 'yay -Rnsc'
abbr ys 'yay -Ss'
