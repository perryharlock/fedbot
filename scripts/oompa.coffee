# Description:
#   Get all your oompa loompa images
#
# Commands:
#   fedbot oompa loompa me - Get a random oompa loompa image
#
## Author:
#   perryharlock

createImageListPage = require '../lib/http-image-list'

module.exports = (robot) ->

  images = [
    "http://i.imgur.com/XrbkNVe.jpg", # Adam
    "http://i.imgur.com/JvJxPlz.jpg", # Lisa
    "http://i.imgur.com/Mrd5Apn.jpg", # Jude
    "http://i.imgur.com/eOWeQQp.jpg", # Glynn
    "http://i.imgur.com/lIE7KnC.jpg", # Hollie
    "http://i.imgur.com/K93CfhC.jpg", # Laura
    "http://i.imgur.com/RFRXZKN.jpg", # Alex
    "http://i.imgur.com/l0YXwd2.jpg", # Phil
    "http://i.imgur.com/KNfMVtA.jpg", # Rowan
    "http://i.imgur.com/9atzwFP.jpg", # Jose
    "http://i.imgur.com/MZtvuUW.jpg", # Nick
    "http://i.imgur.com/07dYBBm.jpg", # Andrew
    "http://i.imgur.com/EKWVfQ6.jpg", # Dan
    "http://i.imgur.com/3G6yPST.png", # Perry
    "http://i.imgur.com/yuzcaIv.jpg", # Jansher
    "http://i.imgur.com/V95JnR9.jpg"  # Luke
  ]

  robot.hear /\b(oompa loompa me)\b/i, (msg) ->
    msg.send msg.random images

  createImageListPage(
    robot,
    '/oompa',
    'Oompa Loompa images',
    'A list of all the oompa loompa images:',
    images
  )
