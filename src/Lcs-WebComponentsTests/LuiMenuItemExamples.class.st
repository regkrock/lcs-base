Class {
	#name : 'LuiMenuItemExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiMenuItemExamples >> homeMenuItemWithImageAndSpan [
	<gtExample>
	| item |
	item := self newMenuItem.
	item label: 'Home'.
	item title: 'Home Button'.
	self assert: item attributes hasTitleAttribute.
	self assert: item hasSpanComponent.

	item imageComponent
		cssClass: 'logo';
		url: LcsFileLibrary / #checkSvg.	

	self assert: item title equals: 'Home Button'.
	self assert: item spanComponent text equals: 'Home'.
	self assertRendered: item equals: '<li name="menuItem1" data-StClass="LuiMenuItem" title="Home Button" class="mainMenuItem"><img alt="" id="261575835" name="image" data-StClass="LuiImage" class="logo" src="/files/LcsFileLibrary/check.svg"/><span id="58284198" name="span" data-StClass="LuiSpan">Home</span></li>'.
	^ item
]

{ #category : 'examples' }
LuiMenuItemExamples >> homeMenuItemWithTextInASpan [
	<gtExample>
	| item |
	item := self newMenuItem.
	item buildFrom: LuiMenuItemDefinitionExamples new homeMenuItemDefinitionWithButton.
	self assert: item attributes hasTitleAttribute.
	self deny: item hasTextDecoration.

	self assert: item title equals: 'abc'.
	self assert: item label equals: 'Home'.
	self assertRendered: item equals: '<li name="menuItem1" data-StClass="LuiMenuItem" title="abc" class="mainMenuItem"><span id="58284198" name="span" data-StClass="LuiSpan">Home</span></li>'.
	^ item
]

{ #category : 'examples' }
LuiMenuItemExamples >> homeMenuItemWithimage [
	<gtExample>
	| item |
	item := self newMenuItem.
	item title: 'Home'.
	item imageComponent
		cssClass: 'logo';
		url: LcsFileLibrary / #checkSvg.	
	self assert: item attributes hasTitleAttribute.
	self assert: item hasImageComponent.

	self assert: item title equals: 'Home'.
	self assertRendered: item equals: '<li name="menuItem1" data-StClass="LuiMenuItem" title="Home" class="mainMenuItem"><img alt="" id="261575835" name="image" data-StClass="LuiImage" class="logo" src="/files/LcsFileLibrary/check.svg"/></li>'.
	^ item
]

{ #category : 'examples' }
LuiMenuItemExamples >> newMenuItem [
	<gtExample>
	| item |
	item := LuiMenuItem named: 'menuItem1'.
	self deny: item attributes hasTitleAttribute.
	self deny: item hasSpanComponent.
	self deny: item hasImageComponent.
	self assert: item hasNoComponents.
	self assert: item componentName equals: 'menuItem1'.
	self
		assertRendered: item
		equals: '<li name="menuItem1" data-StClass="LuiMenuItem" class="mainMenuItem"></li>'.
	^ item
]
