function play_music {
  numberOfPlaylists=$(osascript -e 'tell application "Music"
    activate
    get count of playlists
  end tell')

  playlistNumber=$(jot -r 1  1 $(($numberOfPlaylists - 1)))

  touch randomPlaylistSongCounter
  echo tell application \"Music\" >> randomPlaylistSongCounter
  echo get count of tracks of playlist $playlistNumber >> randomPlaylistSongCounter
  echo end tell >> randomPlaylistSongCounter
  numberOfSongs=$(osascript randomPlaylistSongCounter)
  rm randomPlaylistSongCounter

  songNumber=$(jot -r 1  1 $(($numberOfSongs - 1)))

  touch randomSongPlayer
  echo tell application \"Music\" >> randomSongPlayer
  echo play track $songNumber of playlist $playlistNumber >> randomSongPlayer
  echo end tell >> randomSongPlayer
  osascript randomSongPlayer
  if [ $? != 0 ]
  then
    rm randomSongPlayer
    return 1
  else
    rm randomSongPlayer
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

