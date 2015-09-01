# OpenFL Away3D Actuate Demo
3D tweening demo using OpenFL, Away3D, Actuate, and Haxe


# Getting started

This is a [Haxe](http://haxe.org/) project demonstrating tweening, built with [OpenFL](http://www.openfl.org/), [Away3D](http://away3d.com/), and [Actuate](https://github.com/openfl/actuate).

### Install Haxe

If you don't already have Haxe installed, start by [installing](http://haxe.org/download/) either Mac, Linux, or Windows packages.

### Library Dependencies

If this is your first time running haxelib, setup by executing the following command:

    $ haxelib setup

##### Install Lime

    $ haxelib install lime
    $ haxelib run lime setup
    
##### Install OpenFL

    $ haxelib install openfl
    $ haxelib run openfl setup
    
##### Install Actuate

    $ haxelib install actuate
    
##### Install Away3D

    $ haxelib install away3d

Note that with the current production Away3D v1.1.0 from haxelib is not compatible with this project. 

Until the Away3D haxelib is updated, use the latest git repository by cloning the repo for use as a development haxelib:

    $ git clone https://github.com/away3d/away3d-core-openfl.git
    $ haxelib dev away3d ./away3d-core-openfl

##### Troubleshooting

For other compiler errors, make sure libraries are updated to the latest versions by calling:

    $ haxelib upgrade


# Building and running

To run, call `openfl` with a target, such as:

    $ cd openfl-away3d-terrain-demo/
    $ openfl test flash

And you end up with:

![screen-capture](http://labs.jasonsturges.com/openfl/openfl-away3d-actuate-demo/openfl-away3d-actuate-demo.png)
