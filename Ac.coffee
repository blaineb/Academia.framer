exports.imagePath = "https://dl.dropboxusercontent.com/u/12848031/FramerAssets/Academia/"

exports.color =
	blue			:	"#6288a5"
	green			:	"#92aa4a"
	red				:	"#e83a30"
	orange			:	'#e86830'
	yellow			:	'#e8b730'
	grayDarkest 	: 	'#4b4b4b'
	grayDarker 		: 	'#777777'
	grayDark 		:	'#999999'
	gray			:	'#cccccc'
	grayLight		:	'#dddddd'
	grayLighter		:	'f1f1f1'
	grayLightest	:	'f8f8f8'
	facebook		:	'3B5998'
	twitter			:	'00aced'
	google 			: 	'dd4b39'


exports.people =
	"ann" 		: { image: "avatar-ann.png"	, 	firstName: "Ann", 		lastName: "Hirsch" 	 }
	"ben" 		: { image: "avatar-ben.png" , 	firstName: "Ben", 		lastName: "Lund" 	 }
	"bill" 		: { image: "avatar-bill.png", 	firstName: "Bill", 		lastName: "Withers"  }
	"edmund" 	: { image: "avatar-edmund.png", firstName: "Edmund", 	lastName: "King" 	 }
	"max" 		: { image: "avatar-max.png", 	firstName: "Max", 		lastName: "Schwartz" }
	"ned" 		: { image: "avatar-ned.png", 	firstName: "Ned", 		lastName: "Flanders" }
	"patrick" 	: { image: "avatar-patrick.png",firstName: "Patrick", 	lastName: "Hershey"  }
	"stuart" 	: { image: "avatar-stuart.png", firstName: "Stuart", 	lastName: "Riboff" 	 }
	"tim" 		: { image: "avatar-tim.png", 	firstName: "Tim", 		lastName: "Marcus" 	 }
	"zach" 		: { image: "avatar-zach.png", 	firstName: "Zach", 		lastName: "Foster" 	 }

exports.sizes =
	'xs' : 28
	'sm' : 36
	'md' : 44
	'lg' : 52
	'xl' : 60
	'xxl' : 200

class exports.Avatar extends Layer

	constructor: (@options={}) ->

		#Custom properties
		@options.size  ?= 'md'
		@options.person ?= Utils.randomChoice(Object.keys(exports.people))
		
		#Framer properties
		@options.image ?= exports.imagePath + exports.people[@options.person].image
		@options.width ?= exports.sizes[@options.size]
		@options.height ?= exports.sizes[@options.size]
		@options.borderRadius ?= 3
		
		super @options
# 		@options.person
	@define "person",
		get: -> @options.person
		set: (value) ->
			@options.person = value
			@options.image = exports.imagePath + exports.people[@options.person].image
	@define "size",
		get: -> @options.size
		set: (value) ->
			@options.size = value
			@options.width = exports.sizes[value]
			@options.height = exports.sizes[value]
			@options.borderRadius = sizes[value]/2

class exports.UserCard extends Layer
	constructor: (@options={}) ->

		#Custom properties
		@options.avSize  ?= 'md'
		@options.person ?= Utils.randomChoice(Object.keys(exports.people))
		
		#Framer properties
# 		@options.image ?= imagePath + people[@options.person].image
		@options.width ?= 400
		@options.height ?= (@options.padding * 2) + exports.avSizes[@options.avSize]
		@options.borderRadius ?= 4
		@options.backgroundColor ?= "white"
		@options.shadowY ?= 1
		@options.shadowBlur ?= 3
		@options.shadowColor ?= "rgba(0,0,0,.15)"
		@options.avSize ?= 'md'
		@options.padding ?= 24
		super @options
		
		@_buildAvatar()
		@_buildName()
# 		print @options.avSize
	@define "person",
		get: -> @options.person
		set: (value) ->
			@options.person = value
# 			@options.image = imagePath + people[@options.person].image
	@define "padding",
		get: -> @options.padding
		set: (value) ->
			@options.padding = value
	
	@define "avSize",
		get: -> @options.avSize
		set: (value) ->
			@options.avSize = value

	_buildAvatar: ->
		@_av = new exports.Avatar
			person: @options.person
			size: @options.avSize
			parent: @
			x: @options.padding
			y: @options.padding
			name: 'avatar'
	_buildName: ->
		@_name = new Layer
			height: @_av.height
			parent: @
			name: exports.people[@options.person].firstName + " text"
			y: @options.padding
			width: @.width - @_av.width - (@options.padding * 3)
			x: (@options.padding * 2) + @_av.width
			html: exports.people[@options.person].firstName + " " + exports.people[@options.person].lastName
			style: 
				"font" : "14px/#{@_av.height}px Roboto"
				"color" : "#444"
			backgroundColor: ""
# 		print @op
# 		print @options.size
# 	@define 'size', @proxyProperty('_av.size', default: 'xx')
class exports.Header extends Layer
	constructor: (@options={}) ->
	
		@options.height ?= 70
		@options.width ?= Screen.width
		@options.backgroundColor ?= "white"
		@options.shadowY ?= 1
		@options.shadowBlur ?= 3
		@options.shadowColor ?= "rgba(0,0,0,.15)"
		super @options
		
		@_buildNav()
	_buildNav: ->
		navContent = new Layer
			image: exports.imagePath + "img-nav.png"
			height: 70
			width: 1170
			parent: @
			name: 'static nav'
			x: Align.center

exports.makeShadow = (layer, elevation) ->
	layer.props =
		shadowY: elevation
		shadowBlur: elevation * 3
		shadowColor: "rgba(0,0,0,.15)"
exports.makeCard = (layer) ->
	layer.props =
		borderRadius: 3
		backgroundColor: "white"
	exports.makeShadow(layer, 1)



exports.basics = ->
	document.body.style.cursor = "auto"
	Utils.insertCSS("@import url('//fonts.googleapis.com/css?family=Roboto:200,400,500,700,300,100');")
	Framer.Defaults.Layer.style =
		"font" : "13px/16px Roboto"
		"color" : "#212121"


# Text Layer
class exports.TextLayer extends Layer
		
	constructor: (options={}) ->
		@doAutoSize = false
		@doAutoSizeHeight = false
		options.backgroundColor ?= if options.setup then "hsla(60, 90%, 47%, .4)" else "transparent"
		options.color ?= "#212121"
		options.lineHeight ?= 1.3
		options.fontFamily ?= "Roboto"
		options.fontSize ?= 13
		options.text ?= "Use layer.text to add text"
		super options
		@style.whiteSpace = "pre-line" # allow \n in .text
		@style.outline = "none" # no border when selected
		
	setStyle: (property, value, pxSuffix = false) ->
		@style[property] = if pxSuffix then value+"px" else value
		@emit("change:#{property}", value)
		if @doAutoSize then @calcSize()
		
	calcSize: ->
		sizeAffectingStyles =
			lineHeight: @style["line-height"]
			fontSize: @style["font-size"]
			fontWeight: @style["font-weight"]
			paddingTop: @style["padding-top"]
			paddingRight: @style["padding-right"]
			paddingBottom: @style["padding-bottom"]
			paddingLeft: @style["padding-left"]
			textTransform: @style["text-transform"]
			borderWidth: @style["border-width"]
			letterSpacing: @style["letter-spacing"]
			fontFamily: @style["font-family"]
			fontStyle: @style["font-style"]
			fontVariant: @style["font-variant"]
		constraints = {}
		if @doAutoSizeHeight then constraints.width = @width
		size = Utils.textSize @text, sizeAffectingStyles, constraints
		if @style.textAlign is "right"
			@width = size.width
			@x = @x-@width
		else
			@width = size.width
		@height = size.height

	@define "autoSize",
		get: -> @doAutoSize
		set: (value) -> 
			@doAutoSize = value
			if @doAutoSize then @calcSize()
	@define "autoSizeHeight",
		set: (value) -> 
			@doAutoSize = value
			@doAutoSizeHeight = value
			if @doAutoSize then @calcSize()
	@define "contentEditable",
		set: (boolean) ->
			@_element.contentEditable = boolean
			@ignoreEvents = !boolean
			@on "input", -> @calcSize() if @doAutoSize
	@define "text",
		get: -> @_element.textContent
		set: (value) ->
			@_element.textContent = value
			@emit("change:text", value)
			if @doAutoSize then @calcSize()
	@define "fontFamily", 
		get: -> @style.fontFamily
		set: (value) -> @setStyle("fontFamily", value)
	@define "fontSize", 
		get: -> @style.fontSize.replace("px","")
		set: (value) -> @setStyle("fontSize", value, true)
	@define "lineHeight", 
		get: -> @style.lineHeight 
		set: (value) -> @setStyle("lineHeight", value)
	@define "fontWeight", 
		get: -> @style.fontWeight 
		set: (value) -> @setStyle("fontWeight", value)
	@define "fontStyle", 
		get: -> @style.fontStyle
		set: (value) -> @setStyle("fontStyle", value)
	@define "fontVariant", 
		get: -> @style.fontVariant
		set: (value) -> @setStyle("fontVariant", value)
	@define "padding",
		set: (value) -> 
			@setStyle("paddingTop", value, true)
			@setStyle("paddingRight", value, true)
			@setStyle("paddingBottom", value, true)
			@setStyle("paddingLeft", value, true)
	@define "paddingTop", 
		get: -> @style.paddingTop.replace("px","")
		set: (value) -> @setStyle("paddingTop", value, true)
	@define "paddingRight", 
		get: -> @style.paddingRight.replace("px","")
		set: (value) -> @setStyle("paddingRight", value, true)
	@define "paddingBottom", 
		get: -> @style.paddingBottom.replace("px","")
		set: (value) -> @setStyle("paddingBottom", value, true)
	@define "paddingLeft",
		get: -> @style.paddingLeft.replace("px","")
		set: (value) -> @setStyle("paddingLeft", value, true)
	@define "textAlign",
		set: (value) -> @setStyle("textAlign", value)
	@define "textTransform", 
		get: -> @style.textTransform 
		set: (value) -> @setStyle("textTransform", value)
	@define "letterSpacing", 
		get: -> @style.letterSpacing.replace("px","")
		set: (value) -> @setStyle("letterSpacing", value, true)
	@define "length", 
		get: -> @text.length

class exports.Button extends Layer
    # initialization
	constructor: (@options={}) ->
# 		@hasIcon = false # TODO
		@hasText = true

		@btnTextSizes = 
			'xs' : 9
			'sm' : 11
			'md' : 12
			'lg' : 13
			'xl' : 14
# 			'xxl' : 200

		# Custom stuff
		@options.action ?= null		#Set a function for the onClick Event.
		@options.btnSize ?= "sm"	# Button size
		@options.btnColor ?= exports.color.blue # Color
		@options.sidePadding ?= 24
		@options.width ?= 0
		@options.text ?= "Download"	# Text
# 		@options.icon ?= "" # TODO
		@options.inverse ?= false	# Invert the button?
		
		# Basic styles
		@options.borderColor ?= "rgba(0,0,0,.15)"
		@options.borderWidth ?= 1
		@options.borderRadius ?= 3
		
		#Derived styles
		@options.html = @options.text
		@options.style =
			"line-height" : exports.sizes[@options.btnSize] + "px"
			"font-family" : "Roboto"
			"text-transform" : "uppercase"
			"font-weight" : "bold"
			"text-align" : "center"
			"font-size" : @btnTextSizes[@options.btnSize] + "px"
			"cursor" : "pointer"
		
		@btnStyles = @options.style # For later
		
		if @options.width == 0 then @autoWidth = true
		if @autoWidth then @options.width = _autoBtnWidth(@)


		if @options.inverse is false then @options.backgroundColor = @options.btnColor
		else
			@options.color = @options.btnColor
			@options.backgroundColor = ""
		
		super @options
		
		# When you click this button, it does something
		@.on Events.Click, -> if @options.action != null then @options.action()
		
	# Set a function for the onClick Event.
	@define 'action',
		get: -> @options.action
		set: (value) -> @options.action = value

	@define 'sidePadding',
		get: -> @options.sidePadding
		set: (value) -> @options.sidePadding = value
		
	@define 'btnSize',
		get: -> @options.btnSize
		set: (value) -> 
			@options.btnSize = value
			@options.height = sizes[value]
			@options.style =
				"line-height" : sizes[value] + "px"
				"font-size" : @btnTextSizes[value] + "px"
			if @options.autoWidth is true
				@options.width = _autoBtnWidth(@)
				print @options.width

	@define 'btnColor',
		get: -> @options.btnColor
		set: (value) -> 
			@options.btnColor = value
			if @options.inverse is false
				@options.backgroundColor = value
			else
				@options.color = value	
		
	_autoBtnWidth = (btn) -> 
		Utils.round(Utils.textSize(btn.text, btn.btnStyles, true).width + (btn.sidePadding * 2)) 



exports.bg = new BackgroundLayer backgroundColor: "#f1f1f1", name: 'bg'
exports.nav = new exports.Header
	parent: exports.bg, name: 'header'
exports.setUpNormalStuff()