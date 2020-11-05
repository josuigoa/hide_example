# Heaps IDE example project

This is a sample project to show a very basic usage of [hide](https://github.com/heapsio/hide). This is what it contains:

* Create a custom prefab. Extending the existing Box prefab, adds a color property. The `ColorBox` [code](src/prefab/ColorBox.hx) is commented.
* Create a [hide extension plugin](https://github.com/HeapsIO/hide#extending-hide) to use the `ColorBox` prefab in the editor.
* Use hide to create a simple level for our game.
  * Download a [nightly build](https://github.com/HeapsIO/hide#nightly-builds).
  * Open our newly created project (or this sample project) in hide.
  * Hide shows in the left panel the resources folder of our project (`res` by default).
  * You can create a new level. In the left panel: Right-click->New->Level3D and name it (i.e. testlevel). `testlevel.l3d` file is created.
  * Right-click in the level editor and add what you want: Camera, Light, Particles...
    * You will find our custom prefab `ColorBox` in Right-click->New->3D->ColorBox.
* Load the created level in our game.
  * Check [src/Main.hx](src/Main.hx).
  * It is necessary to add this to our compilation hxml:
    ```
        # include hide defined prefabs (Camera, Light, Bitmap...)
        # if this is not included. Heaps doesn't know how to handle hide default prefabs
        --macro include("hrt")
        # include our custom prefab
        --macro include("prefab")
    ```
