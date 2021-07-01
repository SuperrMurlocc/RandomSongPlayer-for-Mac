# Play random song from your AppleMusic playlist
Feel like listening to something but not quite sure what? Simply paste this into the [Terminal](https://support.apple.com/pl-pl/guide/terminal/apd5265185d-f365-44cb-8b09-71a064a42125/mac) or save as shell script for later use!

### randomSongPlayer.zsh
```zsh
function play_music {
  numberOfPlaylists=$(osascript -e "
    tell application \"Music\"
        activate
        get count of playlists
    end tell
    ")

  playlistNumber=$(jot -r 1  1 $(($numberOfPlaylists - 1)))

  numberOfSongs=$(osascript -e "
    tell application \"Music\"
        get count of tracks of playlist $playlistNumber
    end tell
    ")

  songNumber=$(jot -r 1  1 $(($numberOfSongs - 1)))

  osascript -e "
    tell application \"Music\"
        play track $songNumber of playlist $playlistNumber
    end tell"
  if [ $? != 0 ]
  then
    return 1
  else
    return 0
  fi
}

while [ 1 ]
do
  play_music &> /dev/null
  if [ $? != 1 ]
  then
    break
  fi
done
```
