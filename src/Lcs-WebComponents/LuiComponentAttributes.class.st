Class {
	#name : 'LuiComponentAttributes',
	#superclass : 'Object',
	#instVars : [
		'parentComponent',
		'attributes'
	],
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LuiComponentAttributes class >> on: aComponent [
	^ self new 
		initializeOn: aComponent;
		yourself
]

{ #category : 'rendering' }
LuiComponentAttributes >> _addAttributesToTag: aTag [
	aTag 
		id: self parentComponent componentId;
		name: self parentComponent componentName;
		dataStClass: self parentComponent componentName.
	self attributes do: [ :eachaAtributes | 
			eachaAtributes cachedValue ifNotNil: [ :object |
				aTag
					at: eachaAtributes tagAttributeSetSelector
					put: object ] ]
]

{ #category : 'rendering' }
LuiComponentAttributes >> addAttributesToTag: aTag [
	aTag 
		id: self parentComponent componentId;
		dataName: self parentComponent componentName;
		dataStClass: self parentComponent.
	((aTag respondsTo: #name:) and: [ (aTag isKindOf: WAAnchorTag) not ]) ifTrue: [
		aTag name: self parentComponent componentName ].
	self attributes do: [ :eachaAtributes | 
			eachaAtributes cachedValue ifNotNil: [ :object |
				aTag
					perform: eachaAtributes tagAttributeSetSelector
					with: object ] ]
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> addCssClass: aCssClassName [
	^ self cssClassesAttribute addCssClass: aCssClassName
]

{ #category : 'adding - removing properties' }
LuiComponentAttributes >> addCssClassAttribute [
	| property |
	property := self cssClassesAttribute.
	property addCssClasses: self parentComponent defaultCssClasses
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> addCssClasses: aCollection [
	^ self cssClassesAttribute addCssClasses: aCollection
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> altText [
	self hasAltTextAttribute ifFalse: [ ^ nil ].
	^ self altTextAttribute attributeValue
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> altText: aString [
	^ self altTextAttribute text: aString
]

{ #category : 'properties - defined' }
LuiComponentAttributes >> altTextAttribute [
	^ self lazyInitializedAttribute: LuiAltTextAttribute
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> appendToStyle: aString [
	^ self styleAttribute appendToStyle: aString
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

{ #category : 'properties - delegated' }
LuiComponentAttributes >> beDisabled [
	^ self disabledAttribute beDisabled
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> beEnabled [
	^ self disabledAttribute beEnabled
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> beHidden [
	^ self visibilityAttribute beHidden
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> beNotRenderable [
	^ self renderingAttribute beNotRenderable
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> beOptional [
	^ self requiredAttribute beOptional
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> beRenderable [
	^ self renderingAttribute beRenderable
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> beRequired [
	^ self requiredAttribute beRequired
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> beVisible [
	^ self visibilityAttribute beVisible
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> buttonType [
	self hasButtonTypeAttribute ifFalse: [ ^ nil ].
	^ self buttonTypeAttribute attributeValue
]

{ #category : 'properties - defined' }
LuiComponentAttributes >> buttonTypeAttribute [
	^ self lazyInitializedAttribute: LuiButtonTypeAttribute
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> callback [
	self hasCallbackAttribute ifFalse: [ ^ nil ].
	^ self callbackAttribute attributeValue
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> callback: aBlock [
	^ self callbackAttribute callback: aBlock
]

{ #category : 'properties - defined' }
LuiComponentAttributes >> callbackAttribute [
	^ self lazyInitializedAttribute: LuiCallbackAttribute
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> cssClass: aCssClassName [
	^ self cssClassesAttribute cssClass: aCssClassName
]

{ #category : 'properties - defined' }
LuiComponentAttributes >> cssClassesAttribute [
	^ self lazyInitializedAttribute: LuiCssClassesAttribute
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> cssClassesString [
	self hasCssClassesAttribute ifFalse: [ ^ nil ].
	^ self cssClassesAttribute attributeValue
]

{ #category : 'properties - defined' }
LuiComponentAttributes >> disabledAttribute [
	^ self lazyInitializedAttribute: LuiDisabledAttribute
]

{ #category : 'private' }
LuiComponentAttributes >> errorAttributeNotFound: aSelector [ 
	LuiComponentAttributeNotFound signal: 'Attribute ' , aSelector , ' not found.'
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> forName [
	self hasForNameAttribute ifFalse: [ ^ nil ].
	^ self forNameAttribute attributeValue
]

{ #category : 'properties - defined' }
LuiComponentAttributes >> forName: aString [
	^ self forNameAttribute for: aString
]

{ #category : 'properties - defined' }
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
LuiComponentAttributes >> hasAltTextAttribute [
	^ self hasAttribute: LuiAltTextAttribute attributeName
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

{ #category : 'properties - testing' }
LuiComponentAttributes >> hasCallbackAttribute [
	^ self hasAttribute:  LuiCallbackAttribute attributeName 
]

{ #category : 'properties - testing' }
LuiComponentAttributes >> hasCssClassesAttribute [
	self attributeAt: LuiCssClassesAttribute attributeName ifAbsent: [ ^ false ].
	^ true
]

{ #category : 'properties - testing' }
LuiComponentAttributes >> hasDisabledAttribute [
	^ self hasAttribute:  LuiDisabledAttribute attributeName
]

{ #category : 'properties - testing' }
LuiComponentAttributes >> hasForNameAttribute [
	^ self hasAttribute: LuiForNameAttribute attributeName
]

{ #category : 'properties - testing' }
LuiComponentAttributes >> hasLabelAttribute [
	^ self hasAttribute:  LuiLabelAttribute attributeName 
]

{ #category : 'properties - testing' }
LuiComponentAttributes >> hasNoAttributes [
	^ self attributes isEmpty
]

{ #category : 'properties - testing' }
LuiComponentAttributes >> hasOnClickAttribute [
	^ self hasAttribute: LuiOnClickAttribute attributeName
]

{ #category : 'properties - testing' }
LuiComponentAttributes >> hasRenderingAttribute [
	^ self hasAttribute: LuiRenderingAttribute attributeName
]

{ #category : 'properties - testing' }
LuiComponentAttributes >> hasRequiredAttribute [
	^ self hasAttribute: LuiRequiredAttribute attributeName
]

{ #category : 'properties - testing' }
LuiComponentAttributes >> hasStyleAttribute [
	^ self hasAttribute: LuiStyleAttribute attributeName
]

{ #category : 'properties - testing' }
LuiComponentAttributes >> hasTitleAttribute [
	^ self hasAttribute: LuiTitleAttribute attributeName
]

{ #category : 'properties - testing' }
LuiComponentAttributes >> hasUrlAttribute [
	^ self hasAttribute: LuiUrlAttribute attributeName
]

{ #category : 'properties - testing' }
LuiComponentAttributes >> hasVisiblityAttribute [
	^ self hasAttribute: LuiVisibilityAttribute attributeName 
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

{ #category : 'properties - delegated' }
LuiComponentAttributes >> isDisabled [
	self hasDisabledAttribute ifFalse: [ ^''].
	^ self disabledAttribute isDisabled
]

{ #category : 'testing' }
LuiComponentAttributes >> isEnabled [
	^ self disabledAttribute isEnabled
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> isHidden [
	^ self visibilityAttribute isHidden
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> isNotRenderable [
	self hasRenderingAttribute ifFalse: [ ^ false ].
	^ self renderingAttribute isNotRenderable 
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> isOptional [
	^ self requiredAttribute isOptional
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> isRenderable [
	self hasRenderingAttribute ifFalse: [ ^true ].
	^ self renderingAttribute isRenderable
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> isRequired [
	self hasRequiredAttribute ifFalse: [ ^ false ].
	^ self requiredAttribute isRequired
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> isVisible [
	^ self hasVisiblityAttribute 
		ifTrue: [ self visibilityAttribute isVisible ]
		ifFalse: [ true ]
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> label [
	self hasLabelAttribute ifFalse: [ ^ nil ].
	^ self labelAttribute attributeValue
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> label: aString [
	^ self labelAttribute value: aString
]

{ #category : 'properties - defined' }
LuiComponentAttributes >> labelAttribute [
	^ self lazyInitializedAttribute: LuiLabelAttribute
]

{ #category : 'properties - defined' }
LuiComponentAttributes >> labelAttributeValue [
	^ self hasLabelAttribute 
		ifTrue: [ self labelAttribute attributeValue ]
		ifFalse: [ ^ '' ]
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> labelBlock: aBlock [
	^ self labelAttribute valueBlock: aBlock
]

{ #category : 'properties - accessing' }
LuiComponentAttributes >> lazyInitializedAttribute: aComponentAttributeClassaComponentAttributeClass [
	^ self attributeAt: aComponentAttributeClassaComponentAttributeClass attributeName ifAbsentPut: [ aComponentAttributeClassaComponentAttributeClass on: self ]
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> onClick [
	^ self onClickAttribute onClick
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> onClick: aString [
	^ self onClickAttribute onClick: aString
]

{ #category : 'properties - delegated' }
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

{ #category : 'properties - defined' }
LuiComponentAttributes >> placeholderAttribute [
	^ self lazyInitializedAttribute: LuiPlaceholderAttribute
]

{ #category : 'copying' }
LuiComponentAttributes >> postCopyProperties [
	"Call after super postCopy"
	attributes := attributes copy
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> removeAllCssClasses [
	^ self cssClassesAttribute removeAllCssClasses
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> removeCssClass: aCssClassName [
	^ self cssClassesAttribute removeCssClasses: aCssClassName
]

{ #category : 'properties - defined' }
LuiComponentAttributes >> renderingAttribute [
	^ self lazyInitializedAttribute: LuiRenderingAttribute
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> replaceExistingCssClassesWithCssClass: aString [
	^ self cssClassesAttribute replaceExistingCssClassesWithCssClass: aString
]

{ #category : 'properties - defined' }
LuiComponentAttributes >> requiredAttribute [
	^ self lazyInitializedAttribute: LuiRequiredAttribute
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> rmoveCssClasses: aCollection [
	^ self cssClassesAttribute removeCssClasses: aCollection
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> style [
	self hasStyleAttribute ifFalse: [ ^ '' ].
	^ self styleAttribute attributeValue
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> style: aString [
	^ self styleAttribute style: aString
]

{ #category : 'properties - defined' }
LuiComponentAttributes >> styleAttribute [
	^ self lazyInitializedAttribute: LuiStyleAttribute
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> styleBlock: aBlock [
	^ self styleAttribute valueBlock: aBlock
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> title [
	self hasTitleAttribute ifFalse: [ ^ nil ].
	^ self titleAttribute attributeValue
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> title: aString [
	^ self titleAttribute title: aString
]

{ #category : 'properties - defined' }
LuiComponentAttributes >> titleAttribute [
	^ self lazyInitializedAttribute: LuiTitleAttribute
]

{ #category : 'properties - delegated' }
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

{ #category : 'properties - delegated' }
LuiComponentAttributes >> url [
	self hasUrlAttribute ifFalse: [ ^ nil ].
	^ self urlAttribute attributeValue
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> url: aString [
	^ self urlAttribute url: aString
]

{ #category : 'properties - defined' }
LuiComponentAttributes >> urlAttribute [
	^ self lazyInitializedAttribute: LuiUrlAttribute
]

{ #category : 'properties - delegated' }
LuiComponentAttributes >> valueOfAttribute: anAttributeName [
	(self hasAttribute: anAttributeName) ifFalse: [ ^ nil ].
	^ (self attributeAt: anAttributeName) attributeValue
]

{ #category : 'properties - defined' }
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
