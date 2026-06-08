Class {
	#name : 'LuiMenuItemExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiMenuItemExamples >> homeMenuItemWithButtonWithLabelAndImage [
	<gtExample>
	| item expectedHtml |
	item := self newMenuItem.
	item 
		title: 'Home Menu Item';
		buttonOnClick: 'console.log("clicked")';
		label: 'Home';
		imageUrl: LcsFileLibrary / #check24Svg;
		imageCssClass: 'logo'.
	self assert: item attributes hasTitleAttribute.
	self assert: item hasButtonComponent.
	self deny: item hasAnchorComponent.
	self assert: item buttonComponent label equals: 'Home'.

	self assert: item title equals: 'Home Menu Item'.
	self assert: item spanComponent text equals: 'Home'.
	
	expectedHtml := '<li data-name="menuItem1" data-StClass="LuiMenuItem" title="Home Menu Item" class="menuItem"><button id="7186236" data-name="button" data-StClass="LuiPushButton" onclick="console.log(&quot;clicked&quot;)" type="button"><img alt="" id="90001222" data-name="leadingImage" data-StClass="LuiImage" src="/files/LcsFileLibrary/check24.svg" class="logo"/><span id="207767249" data-name="span" data-StClass="LuiSpan">Home</span></button></li>'.
	
	self assertRendered: item equals: expectedHtml.
	^ item
]

{ #category : 'examples' }
LuiMenuItemExamples >> homeMenuItemWithimage [
	<gtExample>
	| item expectedHtml|
	item := self newMenuItem.
	item title: 'Home'.
	item buttonComponent leadingImageComponent
		cssClass: 'logo';
		url: LcsFileLibrary / #check24Svg.	
	self assert: item attributes hasTitleAttribute.
	self assert: item hasButtonComponent.
	self assert: item buttonComponent hasLeadingImageComponent.

	self assert: item title equals: 'Home'.

	expectedHtml := '<li data-name="menuItem1" data-StClass="LuiMenuItem" title="Home" class="menuItem"><button id="7186236" data-name="button" data-StClass="LuiPushButton" type="button"><img alt="" id="90001222" data-name="leadingImage" data-StClass="LuiImage" class="logo" src="/files/LcsFileLibrary/check24.svg"/></button></li>'.

	self assertRendered: item equals: expectedHtml .
	^ item
]

{ #category : 'examples' }
LuiMenuItemExamples >> menuItemWithAnchor [
	<gtExample>
	| item expectedHtml|
	item := self newMenuItem.
	item href: 'a url path'.
	item text: 'Hello'.
	self assert: item hasAnchorComponent.
	self assert: item href equals: 'a url path'.
	self assert: item buttonOrAnchorComponent equals: item anchorComponent.
	self assert: item text equals: 'Hello'.

	expectedHtml := '<li name="menuItem1" data-StClass="LuiMenuItem" class="menuItem"><a id="244689551" name="anchor" data-StClass="LuiAnchor" href="a url path">Hello</a></li>'.

	"self assertRendered: item equals: expectedHtml ."
	^ item
]

{ #category : 'examples' }
LuiMenuItemExamples >> menuItemWithAnchorAndSpanLabel [
	<gtExample>
	| item expectedHtml|
	item := self newMenuItem.
	item href: 'a url path'.
	item label: 'Hello'.
	self assert: item hasAnchorComponent.
	self assert: item href equals: 'a url path'.
	self assert: item buttonOrAnchorComponent equals: item anchorComponent.
	self assert: item label equals: 'Hello'.

	expectedHtml := '<li data-name="menuItem1" data-StClass="LuiMenuItem" class="menuItem"><a id="244689551" data-name="anchor" data-StClass="LuiAnchor" href="a url path"><span id="177640440" data-name="span" data-StClass="LuiSpan">Hello</span></a></li>'.

	self assertRendered: item equals: expectedHtml .
	^ item
]

{ #category : 'examples' }
LuiMenuItemExamples >> menuItemWithButton [
	<gtExample>
	| item expectedHtml|
	item := self newMenuItem.
	item onClick: 'console.log("clicked")'.
	item text: 'Hello'.
	self assert: item hasButtonComponent.
	self assert: item onClick equals: 'console.log("clicked")'.
	self assert: item buttonOrAnchorComponent equals: item buttonComponent.
	self assert: item text equals: 'Hello'.

	expectedHtml := '<li data-name="menuItem1" data-StClass="LuiMenuItem" class="menuItem"><button id="7186236" data-name="button" data-StClass="LuiPushButton" onclick="console.log(&quot;clicked&quot;)" type="button">Hello</button></li>'.

	self assertRendered: item equals: expectedHtml .
	^ item
]

{ #category : 'examples' }
LuiMenuItemExamples >> menuItemWithButtonAndSpanLabel [
	<gtExample>
	| item expectedHtml|
	item := self newMenuItem.
	item onClick: 'console.log("clicked")'.
	item label: 'Hello'.
	self assert: item hasButtonComponent.
	self assert: item onClick equals: 'console.log("clicked")'.
	self assert: item buttonOrAnchorComponent equals: item buttonComponent.
	self assert: item label equals: 'Hello'.

	expectedHtml := '<li data-name="menuItem1" data-StClass="LuiMenuItem" class="menuItem"><button id="7186236" data-name="button" data-StClass="LuiPushButton" onclick="console.log(&quot;clicked&quot;)" type="button"><span id="207767249" data-name="span" data-StClass="LuiSpan">Hello</span></button></li>'.

	self assertRendered: item equals: expectedHtml .
	^ item
]

{ #category : 'examples' }
LuiMenuItemExamples >> newMenuItem [
	<gtExample>
	| item |
	item := LuiMenuItem named: 'menuItem1'.
	self deny: item attributes hasTitleAttribute.
	self deny: item hasButtonComponent.
	self deny: item hasAnchorComponent.
	self assert: item hasNoComponents.
	self assert: item componentName equals: 'menuItem1'.
	self
		assertRendered: item
		equals: '<li data-name="menuItem1" data-StClass="LuiMenuItem" class="menuItem"></li>'.
	^ item
]
