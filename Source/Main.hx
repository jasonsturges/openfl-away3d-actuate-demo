/*
     |      | _)  |    |   _)
     __ \   |  |  __|  __|  |  __ \    _` |
     |   |  |  |  |    |    |  |   |  (   |
    _.__/  _| _| \__| \__| _| _|  _| \__, |
                                     |___/
    Blitting, http://blitting.com
    Copyright (c) 2014 Jason Sturges, http://jasonsturges.com
*/
package;

import flash.Lib;

import openfl.display.StageAlign;
import openfl.display.StageScaleMode;
import openfl.events.TimerEvent;
import openfl.geom.Vector3D;
import openfl.utils.Timer;

import motion.Actuate;

import away3d.core.base.Object3D;
import away3d.entities.Mesh;
import away3d.lights.DirectionalLight;
import away3d.materials.ColorMaterial;
import away3d.materials.lightpickers.StaticLightPicker;
import away3d.materials.methods.FilteredShadowMapMethod;
import away3d.primitives.CubeGeometry;


class Main extends Away3dViewport {

//------------------------------
//  model
//------------------------------

    public var materials:Array<ColorMaterial>;
    public var meshes:Array<Mesh>;
    public var light:DirectionalLight;
    public var lightPicker:StaticLightPicker;
    public var timer:Timer;
    public static inline var COUNT:UInt = 64;


//------------------------------
//  lifecycle
//------------------------------

    public function new() {
        super();

        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
    }

    override public function initialize():Void {
        super.initialize();

        // TODO: Unknown issue with RandomTimer in calculations.
        //       Once isolated, replaced Timer
        //timer = new RandomTimer(500, 1500);

        timer = new Timer(1000);
        timer.addEventListener(TimerEvent.TIMER, timerHandler);
        timer.start();
    }

    override public function initializeCamera():Void {
        super.initializeCamera();

        camera.lens.far = 10000.0;
        camera.lens.near = 50.0;
    }

    override public function initializeLights():Void {
        super.initializeLights();

        light = new DirectionalLight(-300, -300, -500);
        light.color = 0xefefef;
        light.ambient = 1;
        scene.addChild(light);

        lightPicker = new StaticLightPicker([ light ]);
    }

    override public function initializeMaterials():Void {
        super.initializeMaterials();

        materials = new Array<ColorMaterial>();

        var f:Float = 0xff / COUNT;

        for (i in 0 ... COUNT) {
            var material:ColorMaterial = new ColorMaterial(Std.int(i * f) << 16 | Std.int(i * f) << 8 | Std.int(i * f));
            material.shadowMethod = new FilteredShadowMapMethod(light);
            material.lightPicker = lightPicker;
            material.specular = 0.1;
            materials.push(material);
        }
    }

    override public function initializeObjects():Void {
        super.initializeObjects();

        meshes = new Array<Mesh>();

        for (i in 0 ... COUNT) {
            var mesh:Mesh = new Mesh(new CubeGeometry(20, 20, 20), materials[i]);
            mesh.castsShadows = true;

            meshes.push(mesh);
            view.scene.addChild(mesh);
        }
    }

    public function timerHandler(event:TimerEvent):Void {
        var sx:Float = Math.random() * 3;
        var sy:Float = Math.random() * 3;
        var sz:Float = Math.random() * 2;
        var yaw:Float = Math.random() * 1000;
        var pitch:Float = Math.random() * 1200;
        var dist:Float = Math.random() * 500 + 250;
        var lookAtZero:Bool = Math.random() > 0.5 ? true : false;

        for (i in 0 ... meshes.length) {
            var mesh:Mesh = meshes[i];
            var n:Float = i / meshes.length - 0.5;

            var o:Object3D = new Object3D();
            o.yaw(yaw * n);
            o.pitch(pitch * n);
            o.moveForward(dist);
            o.scaleX = sx;
            o.scaleY = sy;
            o.scaleZ = sz;

            if (lookAtZero)
                o.lookAt(Vector3D.X_AXIS);

            Actuate.tween(mesh, (timer.delay - 250) / 1000, {
                scaleX: o.scaleX,
                scaleY: o.scaleY,
                scaleZ: o.scaleZ,
                rotationX: o.rotationX,
                rotationY: o.rotationY,
                rotationZ: o.rotationZ,
                x: o.x,
                y: o.y,
                z: o.z,
            });

            o.dispose();
            o = null;
        }

        // TODO: Remove once RandomTimer implementation issues are resolved.
        timer.reset();
        timer.removeEventListener(TimerEvent.TIMER, timerHandler);
        timer = new Timer(Math.random() * 1000 + 500);
        timer.addEventListener(TimerEvent.TIMER, timerHandler);
        timer.start();
    }

    override public function prerender():Void {
        super.prerender();

        light.direction = Vector3D.X_AXIS;
        camera.lookAt(Vector3D.X_AXIS);

        camera.x = light.x = Math.sin(Lib.getTimer() / 3000) * 1000;
        camera.z = light.z = Math.cos(Lib.getTimer() / 3000) * 1000;
    }

}
