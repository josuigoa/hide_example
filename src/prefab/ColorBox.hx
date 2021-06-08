package prefab;

import hrt.prefab.Context;

class ColorBox extends hrt.prefab.l3d.Box {
	
	var color:Int;
	
	public function new(?parent) {
        super(parent);
		type = "colorBox";
	}
	
	override function setColor(ctx:Context, color:Int) {
		super.setColor(ctx, color);
		
		#if !editor
		if(ctx.local3d == null)
			return;
		var mesh = Std.downcast(ctx.local3d, h3d.scene.Mesh);
		if(mesh != null) 
			mesh.material.color.setColor(color);
		#end
	}
	
	override function save() {
		var o:Dynamic = super.save();
		
		// prepare to save our new property to the JSON file
		o.color = color;
		//
		
		return o;
	}
	
	override public function load(v:Dynamic) {
		super.load(v);
		
		// load our new property from saved JSON file
		color = v.color;
	}

    override function makeInstance(ctx:Context):Context {
		var ret = super.makeInstance(ctx);
		
		// apply our property
		// add full alpha to the color
		setColor(ctx, 255 << 24 | color);
		
        return ret;
    }
	
	override function updateInstance( ctx: Context, ?propName : String ) {
		super.updateInstance(ctx, propName);
		
		// add full alpha to the color
		setColor(ctx, 255 << 24 | color);
	}
    
    #if editor
	override function edit( ctx : hide.prefab.EditContext ) {
		super.edit(ctx);
		var props = new hide.Element('
			<div class="group" name="Parameters">
				<dl>
					<dt>Color</dt>
					<dd><input type="color" field="color" /></dd>
				</dl>
			</div>'
		);
		ctx.properties.add(props, this, function(propName) {
			ctx.onChange(this, propName);
		});
    }
    
	override function getHideProps() : hide.prefab.HideProps {
		return { icon : "square", name : "ColorBox" };
	}
	#end
    
	static var _ = hrt.prefab.Library.register("colorBox", ColorBox);
}
