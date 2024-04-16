export XDG_CURRENT_DESKTOP=Budgie:GNOME
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

exec budgie-desktop --builtin --session=budgie-desktop $*
#exec gnome-session --builtin --session=budgie-desktop $*
