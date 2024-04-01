# .dotfiles

Behold, the treasure trove of my .dotfiles containing .bash aliases, functions and configuration files! It's like a secret stash of awesomeness, tailored for openSUSE Tumbleweed. But hey, if you're rocking a different distro, fear not! Simply swap out the openSUSE file with one that contains your own magical aliases for your distro of choice, and let the party begin.

> :heart: **Remember Sharing Is Caring**

## How to use

Clone, conquer, and make things happen! Get your hands on the repository like a pro. Make sure to clone it straight into `/home/⟨username⟩`.

```console
git clone https://github.com/siesing/.dotfiles.git
```

Then get your hands on [GNU Stow](https://www.gnu.org/software/stow/). It's brilliant with .dotfiles. Stow is present in most distro repos.

openSUSE

```console
sudo zypper in stow
```

Arch

```console
sudo pacman -S stow
```

Debian/Ubuntu

```console
sudo apt install stow
```

Then 'cd' into the `.dotfiles` directory. Now give those .dotfiles a high-five and hit the runway by running this [stow](https://www.gnu.org/software/stow/) command like there's no tomorrow.

```console
stow .
```

This creates super-powered magical symlinks in your `$HOME` directory to the correct locations, where all the cool aliases and configurations hang out.

Ready for a joyride? Buckle up and open a new terminal for some serious fun! :tada:
