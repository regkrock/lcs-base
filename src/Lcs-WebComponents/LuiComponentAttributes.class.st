Class {
	#name : 'LuiComponentAttributes',
	#superclass : 'Object',
	#instVars : [
		'parentComponent',
		'attributes'
	],
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'instance creation' }
LuiComponentAttributes class >> on: aComponent [
	^ self new 
		initializeOn: aComponent;
		yourself
]

{ #category : 'rendering' }
LuiComponentAttributes >> addAttributesToTag: aTagBrush [
	aTagBrush 
		id: self parentComponent componentId;
		dataName: self parentComponent componentName;
		dataStClass: self parentComponent.
	self attributes do: [ :eachaAtribute | 
			eachaAtribute cachedValue ifNotNil: [ :object |
				aTagBrush
					perform: eachaAtribute tagAttributeSetterSelector
					with: object ] ]
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> addCssClass: aCssClassName [
	^ self cssClassesAttribute addCssClass: aCssClassName
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> addCssClassAttribute [
	| property |
	property := self cssClassesAttribute.
	property addCssClasses: self parentComponent defaultCssClasses
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> addCssClasses: aCollection [
	^ self cssClassesAttribute addCssClasses: aCollection
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> appendToStyleString: aString [
	^ self styleStringAttribute appendToStyleString: aString
]

{ #category : 'subscription' }
LuiComponentAttributes >> attributeAnnounceKey: anAttributeKey oldValue: anOldValue newValue: aNewValue [
	"Announce a property change if there are subscriptions."
	
	self attributeAnnouncerDo: [ :anAnnouncer |
		anOldValue = aNewValue ifFalse: [
			anAnnouncer announce: (MAPropertyChangedAnnouncement new
					owner: self;
					key: anAttributeKey;
					value: aNewValue) ] ]
]

{ #category : 'subscription' }
LuiComponentAttributes >> attributeAnnouncerDo: aBlock [
	"Announce a property change if there are subscriptions."

	self attributes
		at: #attributeAnnouncer
		ifPresent: aBlock
		ifAbsent: [  "ignore" ]
]

{ #category : 'properties - accessing' }
LuiComponentAttributes >> attributeAt: aKey [
	"Answer the value of the property ==aKey==, raises an error if the property doesn't exist."

	^ self attributeAt: aKey ifAbsent: [ self errorAttributeNotFound: aKey ]
]

{ #category : 'properties - accessing' }
LuiComponentAttributes >> attributeAt: aKey ifAbsent: aBlock [
	"Answer the value of the attribute ==aKey==, or the result of ==aBlock== if the attribute doesn't exist."

	^ self attributes at: aKey ifAbsent: aBlock
]

{ #category : 'properties - accessing' }
LuiComponentAttributes >> attributeAt: aKey ifAbsentPut: aBlock [
	"Lookup the property ==aKey==, if it is present, answer the value of evaluating ==aBlock== block with the value. Otherwise, answer ==nil==."

	^ self attributes at: aKey ifAbsentPut: aBlock
]

{ #category : 'properties - accessing' }
LuiComponentAttributes >> attributeAt: aKey ifPresent: aBlock [
	"Lookup the property ==aKey==, if it is present, answer the value of evaluating ==aBlock== block with the value. Otherwise, answer ==nil==."

	^ self attributes at: aKey ifPresent: aBlock
]

{ #category : 'properties - accessing' }
LuiComponentAttributes >> attributeAt: aKey ifPresent: oneArgBlock ifAbsentPut: absentBlock [
	"Lookup ==aKey==, if it is present, answer the value of evaluating the oneArgBlock with the value associated with the key, otherwise answer the value of absentBlock."
	| anOldValue aNewValue |
	anOldValue := nil.
	aNewValue := self attributes 
		at: aKey 
		ifPresent: [ :aValue | 
			anOldValue := aValue. 
			oneArgBlock value ]
		ifAbsentPut: absentBlock.
			
	self attributeAnnounceKey: aKey oldValue: anOldValue newValue: aNewValue.
	
	^ aNewValue
]

{ #category : 'properties - accessing' }
LuiComponentAttributes >> attributeAt: aKey put: aValue [
	"Adds or replaces the property ==aKey== with ==aValue==."

	| anOldValue aNewValue |
	anOldValue := self attributes at: aKey ifAbsent: [ nil ].
	aNewValue := self attributes at: aKey put: aValue.
	
	self attributeAnnounceKey: aKey oldValue: anOldValue newValue: aNewValue.

	^ aNewValue
]

{ #category : 'properties - accessing' }
LuiComponentAttributes >> attributeNamed: aKey [
	^ self attributeAt: aKey ifAbsent: []
]

{ #category : 'accessing' }
LuiComponentAttributes >> attributes [
	^ attributes
]

{ #category : 'accessing' }
LuiComponentAttributes >> attributes: anObject [
	attributes := anObject
]

{ #category : 'gt view' }
LuiComponentAttributes >> attributesSearchOn: aSearch [
	<gtSearch>
	
	^ aSearch list
		title: 'Attributes';
		items: [ self attributes associations ];
		previewObject: [ :assoc | assoc value ];
		filterBySubstring;
		send: [ :anObject | anObject value ]
]

{ #category : 'attributes - commands' }
LuiComponentAttributes >> beDisabled [
	^ self disabledAttribute beDisabled
]

{ #category : 'attributes - commands' }
LuiComponentAttributes >> beEnabled [
	^ self disabledAttribute beEnabled
]

{ #category : 'attributes - commands' }
LuiComponentAttributes >> beHidden [
	^ self visibilityAttribute beHidden
]

{ #category : 'attributes - commands' }
LuiComponentAttributes >> beNotRenderable [
	^ self renderingAttribute beNotRenderable
]

{ #category : 'attributes - commands' }
LuiComponentAttributes >> beOptional [
	^ self requiredAttribute beOptional
]

{ #category : 'attributes - commands' }
LuiComponentAttributes >> beRenderable [
	^ self renderingAttribute beRenderable
]

{ #category : 'attributes - commands' }
LuiComponentAttributes >> beRequired [
	^ self requiredAttribute beRequired
]

{ #category : 'attributes - commands' }
LuiComponentAttributes >> beVisible [
	^ self visibilityAttribute beVisible
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> buttonType [
	self hasButtonTypeAttribute ifFalse: [ ^ nil ].
	^ self buttonTypeAttribute attributeValue
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> buttonType: aString [
	self buttonTypeAttribute buttonType: aString
]

{ #category : 'attributes' }
LuiComponentAttributes >> buttonTypeAttribute [
	^ self lazyInitializedAttribute: LuiButtonTypeAttribute
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> callback [
	self hasCallbackAttribute ifFalse: [ ^ nil ].
	^ self callbackAttribute attributeValue
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> callback: aBlock [
	^ self callbackAttribute callback: aBlock
]

{ #category : 'attributes' }
LuiComponentAttributes >> callbackAttribute [
	^ self lazyInitializedAttribute: LuiCallbackAttribute
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> cssClass: aCssClassName [
	^ self cssClassesAttribute cssClass: aCssClassName
]

{ #category : 'attributes' }
LuiComponentAttributes >> cssClassesAttribute [
	^ self lazyInitializedAttribute: LuiCssClassesAttribute
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> cssClassesString [
	self hasCssClassesAttribute ifFalse: [ ^ nil ].
	^ self cssClassesAttribute attributeValue
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> disable [
	^ self disabledAttribute disable
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> disabled [
	^ self disabledAttribute disabled
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> disabled: aBoolean [
	^ self disabledAttribute disabled: aBoolean
]

{ #category : 'attributes' }
LuiComponentAttributes >> disabledAttribute [
	^ self lazyInitializedAttribute: LuiDisabledAttribute
]

{ #category : 'private' }
LuiComponentAttributes >> errorAttributeNotFound: aSelector [ 
	LuiComponentAttributeNotFound signal: 'Attribute ' , aSelector , ' not found.'
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> for [
	self hasForNameAttribute ifFalse: [ ^ nil ].
	^ self forNameAttribute attributeValue
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> for: aString [
	^ self forNameAttribute for: aString
]

{ #category : 'attributes' }
LuiComponentAttributes >> forNameAttribute [
	^ self lazyInitializedAttribute: LuiForNameAttribute
]

{ #category : 'gt view' }
LuiComponentAttributes >> gtViewAttributesOn: aView [
	<gtView>
	
	self attributes ifNil: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Attributes' translated;
		priority: 70;
		items: [ self attributes associations ];
		column: 'Name' 
			text: [ :a | a key ]
			width: 75;
		column: 'Attribute' text: [ :anAssociation | anAssociation value class name displayString ];
		column: 'Cached' text: [ :anAssociation | anAssociation value cachedValue displayString ];
		column: 'Basic Value' text: [ :anAssociation | anAssociation value _attributeValue displayString ];
		column: 'Block' text: [ :anAssociation | anAssociation value  valueBlock displayString];
		send: [ :e | e value ];
		actionUpdateButton
]

{ #category : 'properties - testing' }
LuiComponentAttributes >> hasAttribute: aaAttributeName [
	self attributeAt: aaAttributeName ifAbsent: [ ^ false ].
	^ true
]

{ #category : 'properties - testing' }
LuiComponentAttributes >> hasAttributeNamed: aString [
	^ (self attributeAt:  aString ifAbsent: [ nil ]) notNil
]

{ #category : 'properties - testing' }
LuiComponentAttributes >> hasAttributes [
	^ self attributes notEmpty
]

{ #category : 'properties - testing' }
LuiComponentAttributes >> hasButtonTypeAttribute [
	^ self hasAttribute: LuiButtonTypeAttribute attributeName
]

{ #category : 'attributes - testing' }
LuiComponentAttributes >> hasCallbackAttribute [
	^ self hasAttribute:  LuiCallbackAttribute attributeName 
]

{ #category : 'attributes - testing' }
LuiComponentAttributes >> hasCssClassesAttribute [
	self attributeAt: LuiCssClassesAttribute attributeName ifAbsent: [ ^ false ].
	^ true
]

{ #category : 'attributes - testing' }
LuiComponentAttributes >> hasDisabledAttribute [
	^ self hasAttribute:  LuiDisabledAttribute attributeName
]

{ #category : 'attributes - testing' }
LuiComponentAttributes >> hasForNameAttribute [
	^ self hasAttribute: LuiForNameAttribute attributeName
]

{ #category : 'attributes - testing' }
LuiComponentAttributes >> hasHiddenAttribute [
	^ self hasAttribute:  LuiVisibilityAttribute attributeName 
]

{ #category : 'attributes - testing' }
LuiComponentAttributes >> hasLabelAttribute [
	^ self hasAttribute:  LuiLabelAttribute attributeName 
]

{ #category : 'attributes - testing' }
LuiComponentAttributes >> hasNoAttributes [
	^ self attributes isEmpty
]

{ #category : 'attributes - testing' }
LuiComponentAttributes >> hasOnClickAttribute [
	^ self hasAttribute: LuiOnClickAttribute attributeName
]

{ #category : 'attributes - testing' }
LuiComponentAttributes >> hasRenderingAttribute [
	^ self hasAttribute: LuiRenderingAttribute attributeName
]

{ #category : 'attributes - testing' }
LuiComponentAttributes >> hasRequiredAttribute [
	^ self hasAttribute: LuiRequiredAttribute attributeName
]

{ #category : 'attributes - testing' }
LuiComponentAttributes >> hasStyleStringAttribute [
	^ self hasAttribute: LuiStyleStringAttribute attributeName
]

{ #category : 'attributes - testing' }
LuiComponentAttributes >> hasTitleAttribute [
	^ self hasAttribute: LuiTitleAttribute attributeName
]

{ #category : 'attributes - testing' }
LuiComponentAttributes >> hasUrlAttribute [
	^ self hasAttribute: LuiUrlAttribute attributeName
]

{ #category : 'attributes - testing' }
LuiComponentAttributes >> hasVisiblityAttribute [
	^ self hasAttribute: LuiVisibilityAttribute attributeName 
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> hidden [
	^ self hiddenAttribute hidden
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> hidden: aBoolean [
	^ self hiddenAttribute for: aBoolean
]

{ #category : 'attributes' }
LuiComponentAttributes >> hiddenAttribute [
	^ self lazyInitializedAttribute: LuiVisibilityAttribute
]

{ #category : 'initialize' }
LuiComponentAttributes >> initialize [
	super initialize.
	self attributes: Dictionary new
]

{ #category : 'initialize' }
LuiComponentAttributes >> initializeCssClassesAttribute [
	self parentComponent ifNil: [ ^ self ].
	self parentComponent defaultCssClasses ifNotEmpty: [
		self addCssClasses: self parentComponent defaultCssClasses ]
]

{ #category : 'initialize' }
LuiComponentAttributes >> initializeOn: aComponent [
	self parentComponent: aComponent.
	self initializeCssClassesAttribute
]

{ #category : 'testing' }
LuiComponentAttributes >> isDisabled [
	^ self disabledAttribute isDisabled
]

{ #category : 'testing' }
LuiComponentAttributes >> isEnabled [
	^ self disabledAttribute isEnabled
]

{ #category : 'testing' }
LuiComponentAttributes >> isHidden [
	^ self hiddenAttribute isHidden
]

{ #category : 'testing' }
LuiComponentAttributes >> isNotRenderable [
	self hasRenderingAttribute ifFalse: [ ^ false ].
	^ self renderingAttribute isNotRenderable 
]

{ #category : 'testing' }
LuiComponentAttributes >> isOptional [
	^ self requiredAttribute isOptional
]

{ #category : 'testing' }
LuiComponentAttributes >> isRenderable [
	self hasRenderingAttribute ifFalse: [ ^true ].
	^ self renderingAttribute isRenderable
]

{ #category : 'testing' }
LuiComponentAttributes >> isRequired [
	self hasRequiredAttribute ifFalse: [ ^ false ].
	^ self requiredAttribute isRequired
]

{ #category : 'testing' }
LuiComponentAttributes >> isVisible [
	^ self hasVisiblityAttribute 
		ifTrue: [ self visibilityAttribute isVisible ]
		ifFalse: [ true ]
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> label [
	self hasLabelAttribute ifFalse: [ ^ nil ].
	^ self labelAttribute attributeValue
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> label: aString [
	^ self labelAttribute value: aString
]

{ #category : 'attributes' }
LuiComponentAttributes >> labelAttribute [
	^ self lazyInitializedAttribute: LuiLabelAttribute
]

{ #category : 'attributes' }
LuiComponentAttributes >> labelAttributeValue [
	^ self hasLabelAttribute 
		ifTrue: [ self labelAttribute attributeValue ]
		ifFalse: [ ^ '' ]
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> labelBlock: aBlock [
	^ self labelAttribute valueBlock: aBlock
]

{ #category : 'properties - accessing' }
LuiComponentAttributes >> lazyInitializedAttribute: aComponentAttributeClassaComponentAttributeClass [
	^ self attributeAt: aComponentAttributeClassaComponentAttributeClass attributeName ifAbsentPut: [ aComponentAttributeClassaComponentAttributeClass on: self ]
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> onClick [
	^ self onClickAttribute onClick
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> onClick: aString [
	^ self onClickAttribute onClick: aString
]

{ #category : 'attributes' }
LuiComponentAttributes >> onClickAttribute [
	^ self lazyInitializedAttribute: LuiOnClickAttribute
]

{ #category : 'accessing' }
LuiComponentAttributes >> parentComponent [
	^ parentComponent
]

{ #category : 'accessing' }
LuiComponentAttributes >> parentComponent: anObject [
	parentComponent := anObject
]

{ #category : 'copying' }
LuiComponentAttributes >> postCopyProperties [
	"Call after super postCopy"
	attributes := attributes copy
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> removeAllCssClasses [
	^ self cssClassesAttribute removeAllCssClasses
]

{ #category : 'properties - accessing' }
LuiComponentAttributes >> removeAttributeKey: aKey [
	"Answer the value of the property ==aKey==, raises an error if the property doesn't exist."

	self attributes removeKey: aKey ifAbsent: [ ]
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> removeCssClass: aCssClassName [
	^ self cssClassesAttribute removeCssClass: aCssClassName
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> removeCssClasses: aCollection [
	^ self cssClassesAttribute removeCssClasses: aCollection
]

{ #category : 'attributes' }
LuiComponentAttributes >> renderingAttribute [
	^ self lazyInitializedAttribute: LuiRenderingAttribute
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> replaceExistingCssClassesWithCssClass: aString [
	^ self cssClassesAttribute replaceExistingCssClassesWithCssClass: aString
]

{ #category : 'attributes' }
LuiComponentAttributes >> requiredAttribute [
	^ self lazyInitializedAttribute: LuiRequiredAttribute
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> rmoveCssClasses: aCollection [
	^ self cssClassesAttribute removeCssClasses: aCollection
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> styleString [
	self hasStyleStringAttribute ifFalse: [ ^ '' ].
	^ self styleStringAttribute attributeValue
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> styleString: aString [
	^ self styleStringAttribute styleString: aString
]

{ #category : 'attributes' }
LuiComponentAttributes >> styleStringAttribute [
	^ self lazyInitializedAttribute: LuiStyleStringAttribute
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> styleStringBlock: aBlock [
	^ self styleStringAttribute valueBlock: aBlock
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> title [
	self hasTitleAttribute ifFalse: [ ^ nil ].
	^ self titleAttribute attributeValue
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> title: aString [
	^ self titleAttribute title: aString
]

{ #category : 'attributes' }
LuiComponentAttributes >> titleAttribute [
	^ self lazyInitializedAttribute: LuiTitleAttribute
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> titleBlock: aBlock [
	^ self titleAttribute valueBlock: aBlock
]

{ #category : 'subscription' }
LuiComponentAttributes >> unsubscribe: aSubscriber [
	self attributes
		at: #attributeAnnouncer
		ifPresent: [ :anAnnouncer | 
			anAnnouncer unsubscribe: aSubscriber ]
		ifAbsent: [  "ignore" ]
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> url [
	self hasUrlAttribute ifFalse: [ ^ nil ].
	^ self urlAttribute attributeValue
]

{ #category : 'attributes - accessing' }
LuiComponentAttributes >> url: aString [
	^ self urlAttribute url: aString
]

{ #category : 'attributes' }
LuiComponentAttributes >> urlAttribute [
	^ self lazyInitializedAttribute: LuiUrlAttribute
]

{ #category : 'properties - accessing' }
LuiComponentAttributes >> valueOfAttribute: anAttributeName [
	(self hasAttribute: anAttributeName) ifFalse: [ ^ nil ].
	^ (self attributeAt: anAttributeName) attributeValue
]

{ #category : 'attributes' }
LuiComponentAttributes >> visibilityAttribute [
	^ self lazyInitializedAttribute:  LuiVisibilityAttribute 
]

{ #category : 'subscription' }
LuiComponentAttributes >> whenAttributeChangedSend: aSelector to: aReceiver [
	| anAnnouncer |
	anAnnouncer := self attributes 
		at: #propertyAnnouncer
		ifAbsentPut: [ Announcer new ].
		
	^ anAnnouncer weak 
		when: MAPropertyChangedAnnouncement
		send: aSelector
		to: aReceiver
]
