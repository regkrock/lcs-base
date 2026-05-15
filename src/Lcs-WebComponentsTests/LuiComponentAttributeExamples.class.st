Class {
	#name : 'LuiComponentAttributeExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiComponentAttributeExamples >> buttonButtonTypeProperty [
	<gtExample>
	| componentAttributes |
	componentAttributes := self newComponentAttributes.
	self assert: componentAttributes buttonTypeAttribute notNil.	"Lazily initialized"
	self assert: (componentAttributes valueOfAttribute: LuiButtonTypeAttribute attributeName) equals: 'button'.
	self assert: componentAttributes buttonType equals: 'button'.
	^ componentAttributes buttonTypeAttribute
]

{ #category : 'examples' }
LuiComponentAttributeExamples >> disabledPropertyInEnabledState [
	<gtExample>
	| properties |
	properties := self newComponentAttributes.
	self deny: properties hasDisabledAttribute.
	self assert: properties isEnabled.
	properties disabledAttribute.
	self assert: properties hasDisabledAttribute.
	self assert: properties isEnabled.
	self deny: properties isDisabled.
	
	properties beDisabled.
	self deny: properties isEnabled.
	self assert: properties isDisabled.
	
	properties beEnabled.
	self assert: properties isEnabled.
	self deny: properties isDisabled.
	^ properties disabledAttribute
]

{ #category : 'examples' }
LuiComponentAttributeExamples >> helloTitlePropertyInitializeFromBlock [
	<gtExample>
	| componentAttributes |
	componentAttributes := self newComponentAttributes.	
	componentAttributes titleBlock: [ 'Hello' ].
	self assert: (componentAttributes valueOfAttribute: LuiTitleAttribute attributeName) equals: 'Hello'.
	self assert: componentAttributes titleAttribute attributeValue equals: 'Hello'.
	self assert: componentAttributes title equals: 'Hello'.
	^ componentAttributes titleAttribute
]

{ #category : 'examples' }
LuiComponentAttributeExamples >> hiddenPropertySetToVisible [
	<gtExample>
	| properties |
	properties := self newComponentAttributes.
	self deny: properties hasVisiblityAttribute.
	self assert: properties isVisible.
	properties visibilityAttribute.
	self assert: properties hasVisiblityAttribute.
	self assert: properties isVisible.
	self deny: properties isHidden.
	
	properties beHidden.
	self deny: properties isVisible.
	self assert: properties isHidden.
	
	properties beVisible.
	self assert: properties isVisible.
	self deny: properties isHidden.
]

{ #category : 'examples' }
LuiComponentAttributeExamples >> newComponentAttributes [
	<gtExample>
	| componentAttributes |
	componentAttributes := LuiComponentAttributes new.
	self assert: componentAttributes attributes isEmpty.
	self deny: (componentAttributes hasAttributeNamed: 'xxxx').
	self deny: componentAttributes hasTitleAttribute.
	self deny: componentAttributes hasCssClassesAttribute.
	self deny: componentAttributes hasDisabledAttribute.
	self deny: componentAttributes hasVisiblityAttribute.
	self deny: componentAttributes hasRequiredAttribute.
	self deny: componentAttributes hasStyleAttribute.
	self deny: componentAttributes hasTitleAttribute.
	self deny: componentAttributes hasButtonTypeAttribute.
	self assert: (componentAttributes valueOfAttribute: LuiButtonTypeAttribute attributeName) isNil.
	self assert: componentAttributes attributes isEmpty.
	^ componentAttributes
]

{ #category : 'examples' }
LuiComponentAttributeExamples >> renderingAttribute [
	<gtExample>
	| properties |
	properties := self newComponentAttributes.
	self deny: properties hasRenderingAttribute.
	self assert: properties isRenderable.
	properties renderingAttribute.
	self assert: properties hasRenderingAttribute.
	self assert: properties isRenderable.
	self deny: properties isNotRenderable.
	
	properties beNotRenderable.
	self deny: properties isRenderable.
	self assert: properties isNotRenderable.
	
	properties beRenderable.
	self assert: properties isRenderable.
	self deny: properties isNotRenderable.
	^ properties renderingAttribute
]

{ #category : 'examples' }
LuiComponentAttributeExamples >> requiredPropertySetToTrue [
	<gtExample>
	| properties |
	properties := self newComponentAttributes.
	self deny: properties hasRequiredAttribute.
	self assert: properties isOptional.
	self assert: properties hasRequiredAttribute.
	self assert: properties isOptional.
	self deny: properties isRequired.
	
	properties beRequired.
	self deny: properties isOptional.
	self assert: properties isRequired.
	
	properties beOptional.
	self assert: properties isOptional.
	self deny: properties isRequired.
	^ properties requiredAttribute
]

{ #category : 'examples' }
LuiComponentAttributeExamples >> submitButtonTypeAttribute [
	<gtExample>
	| componentAttributes |
	componentAttributes := self newComponentAttributes.
	componentAttributes buttonTypeAttribute beSubmitType.
	self assert: (componentAttributes valueOfAttribute: LuiButtonTypeAttribute attributeName) equals: 'submit'.
	self assert: componentAttributes buttonType equals: 'submit'.
	^ componentAttributes buttonTypeAttribute
]

{ #category : 'examples' }
LuiComponentAttributeExamples >> titleCacheIsClearedWhenBlockIsChanged [
	<gtExample>
	| properties |
	properties := self newComponentAttributes.	
	properties title: 'Hello'.
	self assert: properties title equals: 'Hello'.
	self assert: properties titleAttribute cachedValue equals: 'Hello'.
	^ properties titleAttribute
]

{ #category : 'examples' }
LuiComponentAttributeExamples >> titlePropertyLazilyInitialized [
	<gtExample>
	| componentAttributes |
	componentAttributes := self newComponentAttributes.
	self deny: (componentAttributes hasAttribute: LuiTitleAttribute attributeName).
	self assert: (componentAttributes valueOfAttribute: LuiTitleAttribute attributeName) isNil.
	
	self assert: (componentAttributes titleAttribute isKindOf: LuiTitleAttribute).
	self assert: (componentAttributes valueOfAttribute: LuiTitleAttribute attributeName) isNil.
	^ componentAttributes titleAttribute
]

{ #category : 'examples' }
LuiComponentAttributeExamples >> xxxxLabelProperty [
	<gtExample>
	| properties |
	properties := self newComponentAttributes.	
	properties label: 'abcdef'.
	self assert: properties label equals: 'abcdef'.
	self assert: properties labelAttribute cachedValue equals: 'abcdef'.
	properties label: 'Xxxx'.
	self assert: properties labelAttribute basicCachedValue isNil.
	properties label.
	self assert: properties labelAttribute cachedValue equals: 'Xxxx'.
	self assert: properties hasLabelAttribute.
	^ properties labelAttribute
]

{ #category : 'examples' }
LuiComponentAttributeExamples >> xxxxTitleProperty [
	<gtExample>
	| properties |
	properties := self newComponentAttributes.	
	properties title: 'Test'.
	self assert: properties title equals: 'Test'.
	self assert: properties titleAttribute cachedValue equals: 'Test'.
	properties title: 'Xxxx'.
	self assert: properties titleAttribute basicCachedValue isNil.
	properties title.
	self assert: properties titleAttribute cachedValue equals: 'Xxxx'.
	self assert: properties hasTitleAttribute.
	^ properties titleAttribute
]

{ #category : 'examples' }
LuiComponentAttributeExamples >> xxxxYyyyStyleProperty [
	<gtExample>
	| properties |
	properties := self newComponentAttributes.	
	self deny: properties hasStyleAttribute.
	self assert: properties style isEmpty.
	properties style: 'Test'.
	self assert: properties hasStyleAttribute.
	self assert: properties style equals: 'Test'.
	properties style: 'Xxxx'.
	self assert: properties style equals: 'Xxxx'.
	properties appendToStyle: 'Yyyy'.
	self assert: properties style equals: 'XxxxYyyy'.
	^ properties style
]
