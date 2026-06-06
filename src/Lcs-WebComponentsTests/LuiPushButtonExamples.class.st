Class {
	#name : 'LuiPushButtonExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiPushButtonExamples >> buttonWithCallback [
	<gtExample>
	| button callbackBlock |
	callbackBlock := [ 1 + 1 ].
	button := self newButton.
	self deny: button attributes hasCallbackAttribute.
	button callback: callbackBlock.
	self assert: button attributes hasCallbackAttribute.
	self assert: button callback == callbackBlock.
	"Note: The callback block id is stored in the name property"
	self assertRendered: button equals: '<button data-name="button" data-StClass="LuiPushButton" name="1" type="button"></button>'.
	^button
]

{ #category : 'examples' }
LuiPushButtonExamples >> newButton [
	<gtExample>
	| button |
	button := LuiPushButton named: 'button'.
	self assert: button components isEmpty.
	self assert: button parentComponent isNil.
	self deny: button hasLabelComponent.
	self assert: button labelString isEmpty.
	self assert: button attributes buttonType equals: 'button'.
	self assert: button buttonTypeAttribute attributeValue equals: 'button'.
	^ button
]

{ #category : 'examples' }
LuiPushButtonExamples >> okButton [
	<gtExample>
	| button expectedHtml|
	expectedHtml := '<button data-name="button" data-StClass="LuiPushButton" name="button" title="OK Button" type="button">OK</button>'.
	button := self newButton
				text: 'OK';
				title: 'OK Button';
				yourself.
	self assert: button hasNoComponents.
	self deny: button hasSpanComponent.
	self assert: button text equals: 'OK'.
	self assert: button title equals: 'OK Button'.
	self assertRendered: button equals: expectedHtml.
	^button
]

{ #category : 'examples' }
LuiPushButtonExamples >> okButtonWithLeadingCheckIcon [
	<gtExample>
	| button expectedHtml|
	expectedHtml := '<button data-name="button" data-StClass="LuiPushButton" name="button" title="OK Button" type="button"><img alt="" id="201314498" data-name="leadingImage" data-StClass="LuiImage" src="/files/LcsFileLibrary/check24.svg"/><span id="190875853" data-name="span" data-StClass="LuiSpan">OK</span></button>'.
	button := self okButtonWithSpan
				leadingImageUrl: LcsFileLibrary / #check24Svg;
				yourself.
	self assert: button components size = 2.
	self assert: button hasSpanComponent.
	self assert: button label equals: 'OK'.
	self assert: button hasLeadingImageComponent.
	self assert: button leadingImageComponent url equals: LcsFileLibrary / #check24Svg.
	self assert: button leadingImageComponent altText isNil.
	self assertRendered: button equals: expectedHtml.
	^button
]

{ #category : 'examples' }
LuiPushButtonExamples >> okButtonWithSpan [
	<gtExample>
	| button expectedHtml|
	expectedHtml := '<button data-name="button" data-StClass="LuiPushButton" name="button" title="OK Button" type="button"><span id="190875853" data-name="span" data-StClass="LuiSpan">OK</span></button>'.
	button := self newButton
				label: 'OK';
				title: 'OK Button';
				yourself.
	self assert: button components size = 1.
	self assert: button hasSpanComponent.
	self assert: button label equals: 'OK'.
	self assert: button title equals: 'OK Button'.
	self assertRendered: button equals: expectedHtml.
	^button
]

{ #category : 'examples' }
LuiPushButtonExamples >> okButtonWithStyleBorder [
	<gtExample>
	| button expectedHtml|
	expectedHtml := '<button data-name="button" data-StClass="LuiPushButton" name="button" title="OK Button" type="button">OK</button>'.
	button := self okButton
				style: 'border-style: solid border-color: red';
				yourself.
	self assert: button style equals: 'border-style: solid border-color: red'.
	"self assertRendered: button equals: expectedHtml."
	^button
]

{ #category : 'examples' }
LuiPushButtonExamples >> okButtonWithTrailingCheckIcon [
	<gtExample>
	| button expectedHtml|
	expectedHtml := '<button data-name="button" data-StClass="LuiPushButton" name="button" title="OK Button" type="button"><span id="190875853" data-name="span" data-StClass="LuiSpan">OK</span><img alt="" id="41593132" data-name="trailingImage" data-StClass="LuiImage" src="/files/LcsFileLibrary/check24.svg"/></button>'.
	button := self okButtonWithSpan
				trailingImageUrl: LcsFileLibrary / #check24Svg;
				yourself.
	self assert: button components size = 2.
	self assert: button hasSpanComponent.
	self assert: button label equals: 'OK'.
	self assert: button hasTrailingImageComponent.
	self assert: button trailingImageComponent url equals: LcsFileLibrary / #check24Svg.
	self assert: button trailingImageComponent altText isNil.
	self assertRendered: button equals: expectedHtml. 
	^button
]

{ #category : 'examples' }
LuiPushButtonExamples >> okSubmitTypeButton [
	<gtExample>
	| button |
	button := self okButton.
	button beSubmitType.
	self assert: button attributes buttonType equals: 'submit'.
	self assertRendered: button equals: '<button data-name="button" data-StClass="LuiPushButton" name="button" title="OK Button" type="submit">OK</button>'. 
	^button
]

{ #category : 'examples' }
LuiPushButtonExamples >> renderedNewButton [
	<gtExample>
	| button |
	button := self newButton.
	self assertRendered: button equals: '<button data-name="button" data-StClass="LuiPushButton" name="button" type="button"></button>'.
	^ button
]
