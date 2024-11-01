Class {
	#name : #LuiComponentProperties,
	#superclass : #Object,
	#instVars : [
		'properties',
		'parentComponent'
	],
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #'instance creation' }
LuiComponentProperties class >> on: aComponent [
	^ self new 
		initializeOn: aComponent;
		yourself
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> addCssClass: aCssClassName [
	^ self cssClassesProperty addCssClass: aCssClassName
]

{ #category : #'adding - removing properties' }
LuiComponentProperties >> addCssClassProperty [
	| property |
	property := self cssClassesProperty.
	property addCssClasses: self parentComponent defaultCssClasses
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> addCssClasses: aCollection [
	^ self cssClassesProperty addCssClasses: aCollection
]

{ #category : #rendering }
LuiComponentProperties >> addPropertiesToTag: aTag [
	self parentComponent logRenderingTrace.
	aTag
		id: self parentComponent componentId;
		class: self cssClassesString;
		dataName: self parentComponent componentName;
		dataStClass: self parentComponent.
		
	self hasDisabledProperty ifTrue: [
		aTag disabled: self isDisabled ].
		
	self hasRequiredProperty ifTrue: [
		aTag required: self isRequired ].
		
	self hasStyleProperty ifTrue: [
		aTag style: self style ].
		
	self hasTitleProperty ifTrue: [
		aTag title: self title ].

	self hasButtonTypeProperty ifTrue: [
		aTag type: self buttonType ]



]

{ #category : #'properties - delegated' }
LuiComponentProperties >> appendToStyle: aString [
	^ self styleProperty appendToStyle: aString
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> beDisabled [
	^ self disabledProperty beDisabled
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> beEnabled [
	^ self disabledProperty beEnabled
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> beHidden [
	^ self hiddenProperty beHidden
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> beNotRenderable [
	^ self renderingProperty beNotRenderable
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> beOptional [
	^ self requiredProperty beOptional
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> beRenderable [
	^ self renderingProperty beRenderable
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> beRequired [
	^ self requiredProperty beRequired
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> beVisible [
	^ self hiddenProperty beVisible
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> buttonType [
	self hasButtonTypeProperty ifFalse: [ ^ nil ].
	^ self buttonTypeProperty propertyValue
]

{ #category : #'properties - defined' }
LuiComponentProperties >> buttonTypeProperty [
	^ self lazyInitializedProperty: LuiButtonTypeProperty
]

{ #category : #'properties - defined' }
LuiComponentProperties >> cssClassesProperty [
	^ self lazyInitializedProperty: LuiCssClassesProperty
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> cssClassesString [
	self hasCssClassesProperty ifFalse: [ ^ nil ].
	^ self cssClassesProperty propertyValue
]

{ #category : #'properties - defined' }
LuiComponentProperties >> disabledProperty [
	^ self lazyInitializedProperty: LuiDisabledProperty
]

{ #category : #private }
LuiComponentProperties >> errorPropertyNotFound: aSelector [ 
	LuiComponentPropertyNotFound signal: 'Property ' , aSelector , ' not found.'
]

{ #category : #'gt view' }
LuiComponentProperties >> gtViewPropertiesOn: aView [
	<gtView>
	
	self properties ifNil: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Properties' translated;
		priority: 75;
		items: [ self properties associations ];
		column: 'Name' 
			text: [ :a | a key ]
			width: 75;
		column: 'Property' text: [ :anAssociation | anAssociation value class name displayString ];
		column: 'Cached' text: [ :anAssociation | anAssociation value cachedValue displayString ];
		column: 'Basic Value' text: [ :anAssociation | anAssociation value _propertyValue displayString ];
		column: 'Block' text: [ :anAssociation | anAssociation value  valueBlock displayString];
		send: [ :e | e value ];
		actionUpdateButton
]

{ #category : #'properties - testing' }
LuiComponentProperties >> hasButtonTypeProperty [
	self propertyAt: LuiButtonTypeProperty propertyName ifAbsent: [ ^ false ].
	^ true
]

{ #category : #'properties - testing' }
LuiComponentProperties >> hasCssClassesProperty [
	self propertyAt: LuiCssClassesProperty propertyName ifAbsent: [ ^ false ].
	^ true
]

{ #category : #'properties - testing' }
LuiComponentProperties >> hasDisabledProperty [
	self propertyAt: LuiDisabledProperty propertyName ifAbsent: [ ^ false ].
	^ true
]

{ #category : #'properties - testing' }
LuiComponentProperties >> hasHiddenProperty [
	self propertyAt: LuiHiddenProperty propertyName ifAbsent: [ ^ false ].
	^ true
]

{ #category : #'properties - testing' }
LuiComponentProperties >> hasLabelProperty [
	self propertyAt: LuiLabelProperty propertyName ifAbsent: [ ^ false ].
	^ true
]

{ #category : #testing }
LuiComponentProperties >> hasProperty: aKey [
	"Test if the property ==aKey== is defined within the receiver."

	^ self properties includesKey: aKey
]

{ #category : #'properties - testing' }
LuiComponentProperties >> hasRenderingProperty [
	self propertyAt: LuiRenderingProperty propertyName ifAbsent: [ ^ false ].
	^ true
]

{ #category : #'properties - testing' }
LuiComponentProperties >> hasRequiredProperty [
	self propertyAt: LuiRequiredProperty propertyName ifAbsent: [ ^ false ].
	^ true
]

{ #category : #'properties - testing' }
LuiComponentProperties >> hasStyleProperty [
	self propertyAt: LuiStyleProperty propertyName ifAbsent: [ ^ false ].
	^ true
]

{ #category : #'properties - testing' }
LuiComponentProperties >> hasTitleProperty [
	self propertyAt: LuiTitleProperty propertyName ifAbsent: [ ^ false ].
	^ true
]

{ #category : #'properties - defined' }
LuiComponentProperties >> hiddenProperty [
	^ self lazyInitializedProperty:  LuiHiddenProperty 
]

{ #category : #initialize }
LuiComponentProperties >> initialize [
	super initialize.
	self properties: Dictionary new
]

{ #category : #initialize }
LuiComponentProperties >> initializeCssClassesProperty [
	self parentComponent ifNil: [ ^ self ].
	self parentComponent defaultCssClasses ifNotEmpty: [
		self addCssClasses: self parentComponent defaultCssClasses ]
]

{ #category : #initialize }
LuiComponentProperties >> initializeOn: aComponent [
	self parentComponent: aComponent.
	self initializeCssClassesProperty
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> isDisabled [
	self hasDisabledProperty ifFalse: [ ^''].
	^ self disabledProperty isDisabled
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> isEnabled [
	^ self disabledProperty isEnabled
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> isHidden [
	^ self hiddenProperty isHidden
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> isNotRenderable [
	self hasRenderingProperty ifFalse: [ ^ false ].
	^ self renderingProperty isNotRenderable 
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> isOptional [
	^ self requiredProperty isOptional
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> isRenderable [
	self hasRenderingProperty ifFalse: [ ^true ].
	^ self renderingProperty isRenderable
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> isRequired [
	self hasRequiredProperty ifFalse: [ ^ false ].
	^ self requiredProperty isRequired
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> isVisible [
	^ self hasHiddenProperty 
		ifTrue: [ self hiddenProperty isVisible ]
		ifFalse: [ true ]
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> label [
	self hasLabelProperty ifFalse: [ ^ nil ].
	^ self labelProperty propertyValue
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> label: aString [
	^ self labelProperty value: aString
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> labelBlock: aBlock [
	^ self labelProperty valueBlock: aBlock
]

{ #category : #'properties - defined' }
LuiComponentProperties >> labelProperty [
	^ self lazyInitializedProperty: LuiLabelProperty
]

{ #category : #'properties - defined' }
LuiComponentProperties >> labelPropertyValue [
	^ self hasLabelProperty 
		ifTrue: [ self labelProperty propertyValue ]
		ifFalse: [ ^ '' ]
]

{ #category : #'properties - accessing' }
LuiComponentProperties >> lazyInitializedProperty: aComponentPropertyClass [
	^ self propertyAt: aComponentPropertyClass propertyName ifAbsentPut: [ aComponentPropertyClass on: self ]
]

{ #category : #accessing }
LuiComponentProperties >> parentComponent [
	^ parentComponent
]

{ #category : #accessing }
LuiComponentProperties >> parentComponent: anObject [
	parentComponent := anObject
]

{ #category : #copying }
LuiComponentProperties >> postCopyProperties [
	"Call after super postCopy"
	properties := properties copy
]

{ #category : #accessing }
LuiComponentProperties >> properties [
	^ properties
]

{ #category : #accessing }
LuiComponentProperties >> properties: anObject [
	properties := anObject
]

{ #category : #'gt view' }
LuiComponentProperties >> propertiesSearchOn: aSearch [
	<gtSearch>
	
	^ aSearch list
		title: 'Properties';
		items: [ self properties associations ];
		previewObject: [ :assoc | assoc value ];
		filterBySubstring;
		send: [ :anObject | anObject value ]
]

{ #category : #subscription }
LuiComponentProperties >> propertyAnnounceKey: aPropertyKey oldValue: anOldValue newValue: aNewValue [
	"Announce a property change if there are subscriptions."
	
	self propertyAnnouncerDo: [ :anAnnouncer |
		anOldValue = aNewValue ifFalse: [
			anAnnouncer announce: (MAPropertyChangedAnnouncement new
					owner: self;
					key: aPropertyKey;
					value: aNewValue) ] ]
]

{ #category : #subscription }
LuiComponentProperties >> propertyAnnouncerDo: aBlock [
	"Announce a property change if there are subscriptions."

	self properties
		at: #propertyAnnouncer
		ifPresent: aBlock
		ifAbsent: [  "ignore" ]
]

{ #category : #'properties - accessing' }
LuiComponentProperties >> propertyAt: aKey [
	"Answer the value of the property ==aKey==, raises an error if the property doesn't exist."

	^ self propertyAt: aKey ifAbsent: [ self errorPropertyNotFound: aKey ]
]

{ #category : #'properties - accessing' }
LuiComponentProperties >> propertyAt: aKey ifAbsent: aBlock [
	"Answer the value of the property ==aKey==, or the result of ==aBlock== if the property doesn't exist."

	^ self properties at: aKey ifAbsent: aBlock
]

{ #category : #'properties - accessing' }
LuiComponentProperties >> propertyAt: aKey ifAbsentPut: aBlock [
	"Answer the value of the property ==aKey==, or if the property doesn't exist adds and answers the result of evaluating ==aBlock==."

	| aValue shouldAnnounce |
	shouldAnnounce := false.
	
	aValue := self properties 
		at: aKey 
		ifAbsentPut: [
			shouldAnnounce := true.
			aBlock value ].
			
	shouldAnnounce ifTrue: [ 
		self propertyAnnounceKey: aKey oldValue: nil newValue: aValue ].
		
	^ aValue
]

{ #category : #'properties - accessing' }
LuiComponentProperties >> propertyAt: aKey ifPresent: aBlock [
	"Lookup the property ==aKey==, if it is present, answer the value of evaluating ==aBlock== block with the value. Otherwise, answer ==nil==."

	^ self properties at: aKey ifPresent: aBlock
]

{ #category : #'properties - accessing' }
LuiComponentProperties >> propertyAt: aKey ifPresent: oneArgBlock ifAbsent: absentBlock [
	"Lookup ==aKey==, if it is present, answer the value of evaluating the oneArgBlock with the value associated with the key, otherwise answer the value of absentBlock."
	^ self properties at: aKey ifPresent: oneArgBlock ifAbsent: absentBlock
]

{ #category : #'properties - accessing' }
LuiComponentProperties >> propertyAt: aKey ifPresent: oneArgBlock ifAbsentPut: absentBlock [
	"Lookup ==aKey==, if it is present, answer the value of evaluating the oneArgBlock with the value associated with the key, otherwise answer the value of absentBlock."
	| anOldValue aNewValue |
	anOldValue := nil.
	aNewValue := self properties 
		at: aKey 
		ifPresent: [ :aValue | 
			anOldValue := aValue. 
			oneArgBlock value ]
		ifAbsentPut: absentBlock.
			
	self propertyAnnounceKey: aKey oldValue: anOldValue newValue: aNewValue.
	
	^ aNewValue
]

{ #category : #'properties - accessing' }
LuiComponentProperties >> propertyAt: aKey put: aValue [
	"Adds or replaces the property ==aKey== with ==aValue==."

	| anOldValue aNewValue |
	anOldValue := self properties at: aKey ifAbsent: [ nil ].
	aNewValue := self properties at: aKey put: aValue.
	
	self propertyAnnounceKey: aKey oldValue: anOldValue newValue: aNewValue.

	^ aNewValue
]

{ #category : #'properties - accessing' }
LuiComponentProperties >> propertyAt: aSymbol putRemovingNil: aValue [
	
	| anOldValue |
	aValue ifNotNil: [ 
		^ self propertyAt: aSymbol put: aValue ].
	
	anOldValue := (self hasProperty: aSymbol)
		ifTrue: [ self properties removeKey: aSymbol ]
		ifFalse: [ aValue ].
		
	self propertyAnnounceKey: aSymbol oldValue: anOldValue newValue: aValue.
	
	^ anOldValue
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> removeAllCssClasses [
	^ self cssClassesProperty removeAllCssClasses
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> removeCssClass: aCssClassName [
	^ self cssClassesProperty removeCssClasses: aCssClassName
]

{ #category : #'properties - defined' }
LuiComponentProperties >> renderingProperty [
	^ self lazyInitializedProperty: LuiRenderingProperty
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> replaceExistingCssClassesWithCssClass: aString [
	^ self cssClassesProperty replaceExistingCssClassesWithCssClass: aString
]

{ #category : #'properties - defined' }
LuiComponentProperties >> requiredProperty [
	^ self lazyInitializedProperty: LuiRequiredProperty
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> rmoveCssClasses: aCollection [
	^ self cssClassesProperty removeCssClasses: aCollection
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> style [
	self hasStyleProperty ifFalse: [ ^ '' ].
	^ self styleProperty propertyValue
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> style: aString [
	^ self styleProperty style: aString
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> styleBlock: aBlock [
	^ self styleProperty valueBlock: aBlock
]

{ #category : #'properties - defined' }
LuiComponentProperties >> styleProperty [
	^ self lazyInitializedProperty: LuiStyleProperty
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> title [
	self hasTitleProperty ifFalse: [ ^ nil ].
	^ self titleProperty propertyValue
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> title: aString [
	^ self titleProperty title: aString
]

{ #category : #'properties - delegated' }
LuiComponentProperties >> titleBlock: aBlock [
	^ self titleProperty valueBlock: aBlock
]

{ #category : #'properties - defined' }
LuiComponentProperties >> titleProperty [
	^ self lazyInitializedProperty: LuiTitleProperty
]

{ #category : #subscription }
LuiComponentProperties >> unsubscribe: aSubscriber [
	self properties
		at: #propertyAnnouncer
		ifPresent: [ :anAnnouncer | 
			anAnnouncer unsubscribe: aSubscriber ]
		ifAbsent: [  "ignore" ]
]

{ #category : #'properties - accessing' }
LuiComponentProperties >> valueOfProperty: aName [
	^ self propertyAt: aName ifPresent: [ :each | each propertyValue ] ifAbsent: [ nil ]
]

{ #category : #subscription }
LuiComponentProperties >> whenPropertyChangedSend: aSelector to: aReceiver [
	| anAnnouncer |
	anAnnouncer := self properties 
		at: #propertyAnnouncer
		ifAbsentPut: [ Announcer new ].
		
	^ anAnnouncer weak 
		when: MAPropertyChangedAnnouncement
		send: aSelector
		to: aReceiver
]
