Class {
	#name : 'LuButtonExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuButtonExamples >> buttonWithCallback [
	<gtExample>
	| button callbackBlock |
	callbackBlock := [ 1 + 1 ].
	button := self newButton.
	self deny: button attributes hasCallbackAttribute.
	button callback: callbackBlock.
	self assert: button attributes hasCallbackAttribute.
	self assert: button callback == callbackBlock.
	"Note: The callback block id is stored in the name property"
	self assertRendered: button equals: '<button data-name="button" data-StClass="LuiButton" type="button" class="pushButton" name="1"></button>'.
	^button
]

{ #category : 'examples' }
LuButtonExamples >> cancelButton [
	<gtExample>
	| button expectedHtml |
	button := LuiCancelButton new.
	self assert: button components contents size = 2.
	self assert: button parentComponent isNil.
	self deny: button hasLabelComponent.
	self assert: button labelString isEmpty.
	self assert: button attributes buttonType equals: 'submit'.
	self assert: button buttonTypeAttribute attributeValue equals: 'submit'.
	self assert: button leadingImageComponent notNil.
	self assert: button spanComponent text = 'Cancel'.
	expectedHtml := '<button data-name="cancelButton" data-StClass="LuiCancelButton" type="submit" class="pushButton" name="1"><img alt="" id="36695256" data-name="leadingImage" data-StClass="LuiImage" src="/files/LcsFileLibrary/cancel24.svg"/><span id="151812643" data-name="span" data-StClass="LuiSpan">Cancel</span></button>'.
	self assertRendered: button equals: expectedHtml.
	^ button 
]

{ #category : 'examples' }
LuButtonExamples >> newButton [
	<gtExample>
	| button |
	button := LuiButton named: 'button'.
	self assert: button components isEmpty.
	self assert: button parentComponent isNil.
	self deny: button hasLabelComponent.
	self assert: button labelString isEmpty.
	self assert: button attributes buttonType equals: 'button'.
	self assert: button buttonTypeAttribute attributeValue equals: 'button'.
	^ button
]

{ #category : 'examples' }
LuButtonExamples >> okButton [
	<gtExample>
	| button expectedHtml|
	expectedHtml := '<button data-name="button" data-StClass="LuiButton" title="OK Button" type="button" class="pushButton">OK</button>'.
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
LuButtonExamples >> okButtonWithLeadingCheckIcon [
	<gtExample>
	| button expectedHtml|
	expectedHtml := '<button data-name="button" data-StClass="LuiButton" title="OK Button" type="button" class="pushButton"><img alt="" id="201314498" data-name="leadingImage" data-StClass="LuiImage" src="/files/LcsFileLibrary/check24.svg"/><span id="190875853" data-name="span" data-StClass="LuiSpan">OK</span></button>'.
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
LuButtonExamples >> okButtonWithSpan [
	<gtExample>
	| button expectedHtml|
	expectedHtml := '<button data-name="button" data-StClass="LuiButton" title="OK Button" type="button" class="pushButton"><span id="190875853" data-name="span" data-StClass="LuiSpan">OK</span></button>'.
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
LuButtonExamples >> okButtonWithStyleBorder [
	<gtExample>
	| button expectedHtml|
	expectedHtml := '<button data-name="button" data-StClass="LuiPushButton" name="button" title="OK Button" type="button">OK</button>'.
	button := self okButton
				styleString: 'border-style: solid border-color: red';
				yourself.
	self assert: button styleString equals: 'border-style: solid border-color: red'.
	"self assertRendered: button equals: expectedHtml."
	^button
]

{ #category : 'examples' }
LuButtonExamples >> okButtonWithTrailingCheckIcon [
	<gtExample>
	| button expectedHtml|
	expectedHtml := '<button data-name="button" data-StClass="LuiButton" title="OK Button" type="button" class="pushButton"><span id="190875853" data-name="span" data-StClass="LuiSpan">OK</span><img alt="" id="41593132" data-name="trailingImage" data-StClass="LuiImage" src="/files/LcsFileLibrary/check24.svg"/></button>'.
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
LuButtonExamples >> okSubmitTypeButton [
	<gtExample>
	| button |
	button := self okButton.
	button beSubmitType.
	self assert: button attributes buttonType equals: 'submit'.
	self assertRendered: button equals: '<button data-name="button" data-StClass="LuiButton" title="OK Button" type="submit" class="pushButton">OK</button>'. 
	^button
]

{ #category : 'examples' }
LuButtonExamples >> renderedNewButton [
	<gtExample>
	| button |
	button := self newButton.
	self assertRendered: button equals: '<button data-name="button" data-StClass="LuiButton" type="button" class="pushButton"></button>'.
	^ button
]

{ #category : 'examples' }
LuButtonExamples >> saveButton [
	<gtExample>
	| button expectedHtml |
	button := LuiSaveButton new.
	self assert: button components contents size = 2.
	self assert: button parentComponent isNil.
	self deny: button hasLabelComponent.
	self assert: button labelString isEmpty.
	self assert: button attributes buttonType equals: 'submit'.
	self assert: button buttonTypeAttribute attributeValue equals: 'submit'.
	self assert: button leadingImageComponent notNil.
	self assert: button spanComponent text = 'Save'.
	expectedHtml := '<button data-name="saveButton" data-StClass="LuiSaveButton" type="submit" class="pushButton" name="1"><img alt="" id="154651757" data-name="leadingImage" data-StClass="LuiImage" src="/files/LcsFileLibrary/check24.svg"/><span id="144653080" data-name="span" data-StClass="LuiSpan">Save</span></button>'.
	self assertRendered: button equals: expectedHtml.
	^ button 
]
