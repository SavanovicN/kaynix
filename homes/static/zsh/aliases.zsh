alias k="kubectl"
alias kz="kustomize"
alias kname-prd="k config set-context --current --namespace=cloud-prd"
alias kname-stg="k config set-context --current --namespace=cloud-stg"

alias oo="cd $HOME/Documents/obsidian_vault && nvim ."
alias or="nvim $HOME/Documents/obsidian_vault/inbox/*.md"
alias p="pnpm"
alias rd="rmdir"

alias tf=terraform

# SSH wrapper: tint terminal background while connected to a remote host
function ssh() {
  printf '\033]11;#382830\033\\'
  command ssh "$@"
  local ret=$?
  printf '\033]11;#303446\033\\'
  return $ret
}

# Local checkout of this flake repo
KAYNIX_DIR="$HOME/Code/kaynix"

# kaynix rebuild: apply this repo's nix-darwin config to the machine
function kaynix() {
  case "$1" in
    rebuild)
      sudo darwin-rebuild switch --flake "$KAYNIX_DIR#savan-mbp"
      ;;
    *)
      echo "usage: kaynix rebuild" >&2
      return 1
      ;;
  esac
}

# Dev shells -- enter from anywhere
alias shell-default="nix develop $KAYNIX_DIR#default"
alias shell-python="nix develop $KAYNIX_DIR#python"
alias shell-sketchy="nix develop $KAYNIX_DIR#sketchybar"
