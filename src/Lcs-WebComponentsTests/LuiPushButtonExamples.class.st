Class {
	#name : 'LuiPushButtonExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

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
	self assertRendered: button equals: '<button name="button" data-StClass="LuiPushButton" type="button"></button>'.
	^ button
]

{ #category : 'examples' }
LuiPushButtonExamples >> okButton [
	<gtExample>
	| button expectedHtml|
	expectedHtml := '<button name="button" data-StClass="LuiPushButton" title="OK Button" type="button"></button>'.
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
	expectedHtml := '<button name="button" data-StClass="LuiPushButton" title="OK Button" type="button"><img alt="" id="201314498" name="leadingImage" data-StClass="LuiImage" src="/files/LcsFileLibrary/check.svg"/><span id="56603508" name="text" data-StClass="LuiSpan">OK</span></button>'.
	button := self okButton
				leadingImageUrl: LcsFileLibrary / #checkSvg;
				yourself.
	self assert: button components size = 2.
	self assert: button hasSpanComponent.
	self assert: button text equals: 'OK'.
	self assert: button hasLeadingImageComponent.
	self assert: button leadingImageComponent url equals: LcsFileLibrary / #checkSvg.
	self assert: button leadingImageComponent altText isNil.
	"self assertRendered: button equals: expectedHtml. "
	^button
]

{ #category : 'examples' }
LuiPushButtonExamples >> okButtonWithSpan [
	<gtExample>
	| button expectedHtml|
	expectedHtml := '<button name="button" data-StClass="LuiPushButton" title="OK Button" type="button"><span id="190875853" name="span" data-StClass="LuiSpan">OK</span></button>'.
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
LuiPushButtonExamples >> okButtonWithTrailingCheckIcon [
	<gtExample>
	| button expectedHtml|
	expectedHtml := '<button name="button" data-StClass="LuiPushButton" title="OK Button" type="button"><span id="56603508" name="text" data-StClass="LuiSpan">OK</span><img alt="" id="41593132" name="trailingImage" data-StClass="LuiImage" src="/files/LcsFileLibrary/check.svg"/></button>'.
	button := self okButton
				trailingImageUrl: LcsFileLibrary / #checkSvg;
				yourself.
	self assert: button components size = 2.
	self assert: button hasSpanComponent.
	self assert: button text equals: 'OK'.
	self assert: button hasTrailingImageComponent.
	self assert: button trailingImageComponent url equals: LcsFileLibrary / #checkSvg.
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
	self assertRendered: button equals: '<button name="button" data-StClass="LuiPushButton" title="OK Button" type="submit"><span id="56603508" name="text" data-StClass="LuiSpan">OK</span></button>'. 
	^button
]
