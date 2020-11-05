import hrt.prefab.l3d.Camera;

class Main extends hxd.App {
	var testLevel:hrt.prefab.Prefab;
	var levelCameras:Array<Camera>;
	var currentCameraIndex:Int = -1;

	override function init() {
		// The prefab resource needs to be loaded before adding
		// a callback to watch it's changes
		testLevel = hxd.Res.test.load();
		hxd.Res.test.watch(reloadLevel);

		reloadLevel();
		switchCamera();
	}

	function reloadLevel() {
		@:privateAccess s3d.removeChildren();

		// Look for any Unknown prefab in our level tree
		// This means there is something not loaded correctly
		// I got this error until added `--macro include("hrt")` in the hxml
		var unk = testLevel.getOpt(hrt.prefab.Unknown);
		if (unk != null)
			throw "Prefab " + unk.getPrefabType() + " was not compiled";

		// Create and configure prefabs context
		var ctx = new hrt.prefab.Context();
		var shared = new hrt.prefab.ContextShared();
		ctx.shared = shared;
		shared.root2d = s2d;
		shared.root3d = s3d;
		ctx.init();

		// build the loaded level with the newly created context
		testLevel.make(ctx);
		
		// get the level cameras
		levelCameras = testLevel.getAll(hrt.prefab.l3d.Camera);
	}

	override function update(dt:Float) {
		super.update(dt);

		if (hxd.Key.isReleased(hxd.Key.C))
			switchCamera();
	}

	function switchCamera() {
		currentCameraIndex = (currentCameraIndex + 1) % levelCameras.length;
		levelCameras[currentCameraIndex].applyTo(s3d.camera);
	}

	static function main() {
		// I don't know why it is not working propery with default materials
		// so I set the PBR materials to get this working
		h3d.mat.PbrMaterialSetup.set();
		hxd.Res.initLocal();
		new Main();
	}
}
