// PUBLIC VARIABLES, GAME SETUP
var canvas = document.getElementById("canvas");
var ctx = canvas.getContext("2d");
var width = 640;
var height = 640;
var block_size = 32;
canvas.width = width;
canvas.height = height;

ctx.webkitImageSmoothingEnabled = false;
ctx.mozImageSmoothingEnabled = false;
ctx.msImageSmoothingEnabled = false;
ctx.imageSmoothingEnabled = false;

var img_background = document.getElementById("bg1");


// PLAYER AND GAME SETTINGS
var player = {
    x: width / 2,
    y: 200,
    width: 16,
    height: 16,
    speed: 1,
    velX: 0,
    velY: 0,
    jumping: false,
    grounded: false,
    color:'#E6AC27'
},
levels = {},
keys = [],
friction = 0.8,
gravity = 0.1,
colliders = [],
objects = [],
powerup = [],
enemies = [];

// PUBLIC FUNCTION
function var_load(n){
    if (levels[n]) {
        player.x = JSON.parse(JSON.stringify(levels[n].playerx));
        player.y = JSON.parse(JSON.stringify(levels[n].playery));
        colliders = JSON.parse(JSON.stringify(levels[n].colliders || []));
        powerup = JSON.parse(JSON.stringify(levels[n].powerup || []));
        objects = JSON.parse(JSON.stringify(levels[n].objects || []));
        enemies = JSON.parse(JSON.stringify(levels[n].enemies || []));
    }
}

