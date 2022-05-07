alias tmux="agenttmux"
alias at="agenttmux attach -t"
alias tls="agenttmux ls"
if [ "$TMUX" ]; then
    PROMPT_COMMAND='eval "$(/nail/scripts/tmux-env)"; '"$PROMPT_COMMAND"
fi
