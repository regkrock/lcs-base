Class {
	#name : #LuiProperties,
	#superclass : #Object,
	#instVars : [
		'properties',
		'parentComponent'
	],
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #'instance creation' }
LuiProperties class >> on: aComponent [
	^ self new 
		initializeOn: aComponent;
		yourself
]

{ #category : #private }
LuiProperties >> errorPropertyNotFound: aSelector [ 
	MAPropertyError signal: 'Property ' , aSelector , ' not found.'
]

{ #category : #'gt view' }
LuiProperties >> gtViewPropertiesOn: aView [
	<gtView>
	
	self properties ifEmpty: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Properties' translated;
		priority: 75;
		items: [ self properties associations ];
		column: 'Name' 
			text: [ :a | a key ]
			width: 75;
		column: 'Value' text: [ :a | a value ];
		send: [ :e | e value ];
		actionUpdateButton
]

{ #category : #testing }
LuiProperties >> hasProperty: aKey [
	"Test if the property ==aKey== is defined within the receiver."

	^ self properties includesKey: aKey
]

{ #category : #iniitialize }
LuiProperties >> initialize [
	super initialize.
	self properties: Dictionary new
]

{ #category : #initialize }
LuiProperties >> initializeOn: aComponent [ 
	self parentComponent: aComponent
]

{ #category : #accessing }
LuiProperties >> parentComponent [
	^ parentComponent
]

{ #category : #accessing }
LuiProperties >> parentComponent: anObject [
	parentComponent := anObject
]

{ #category : #copying }
LuiProperties >> postCopyProperties [
	"Call after super postCopy"
	properties := properties copy
]

{ #category : #accessing }
LuiProperties >> properties [
	^ properties
]

{ #category : #accessing }
LuiProperties >> properties: anObject [
	properties := anObject
]

{ #category : #'gt view' }
LuiProperties >> propertiesSearchOn: aSearch [
	<gtSearch>
	
	^ aSearch list
		title: 'Properties';
		items: [ self properties associations ];
		previewObject: [ :assoc | assoc value ];
		filterBySubstring;
		send: [ :anObject | anObject value ]
]

{ #category : #subscription }
LuiProperties >> propertyAnnounceKey: aPropertyKey oldValue: anOldValue newValue: aNewValue [
	"Announce a property change if there are subscriptions."
	
	self propertyAnnouncerDo: [ :anAnnouncer |
		anOldValue = aNewValue ifFalse: [
			anAnnouncer announce: (MAPropertyChangedAnnouncement new
					owner: self;
					key: aPropertyKey;
					value: aNewValue) ] ]
]

{ #category : #subscription }
LuiProperties >> propertyAnnouncerDo: aBlock [
	"Announce a property change if there are subscriptions."

	self properties
		at: #propertyAnnouncer
		ifPresent: aBlock
		ifAbsent: [  "ignore" ]
]

{ #category : #properties }
LuiProperties >> propertyAt: aKey [
	"Answer the value of the property ==aKey==, raises an error if the property doesn't exist."

	^ self propertyAt: aKey ifAbsent: [ self errorPropertyNotFound: aKey ]
]

{ #category : #properties }
LuiProperties >> propertyAt: aKey ifAbsent: aBlock [
	"Answer the value of the property ==aKey==, or the result of ==aBlock== if the property doesn't exist."

	^ self properties at: aKey ifAbsent: aBlock
]

{ #category : #properties }
LuiProperties >> propertyAt: aKey ifAbsentPut: aBlock [
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

{ #category : #properties }
LuiProperties >> propertyAt: aKey ifPresent: aBlock [
	"Lookup the property ==aKey==, if it is present, answer the value of evaluating ==aBlock== block with the value. Otherwise, answer ==nil==."

	^ self properties at: aKey ifPresent: aBlock
]

{ #category : #properties }
LuiProperties >> propertyAt: aKey ifPresent: oneArgBlock ifAbsent: absentBlock [
	"Lookup ==aKey==, if it is present, answer the value of evaluating the oneArgBlock with the value associated with the key, otherwise answer the value of absentBlock."
	^ self properties at: aKey ifPresent: oneArgBlock ifAbsent: absentBlock
]

{ #category : #properties }
LuiProperties >> propertyAt: aKey ifPresent: oneArgBlock ifAbsentPut: absentBlock [
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

{ #category : #properties }
LuiProperties >> propertyAt: aKey put: aValue [
	"Adds or replaces the property ==aKey== with ==aValue==."

	| anOldValue aNewValue |
	anOldValue := self properties at: aKey ifAbsent: [ nil ].
	aNewValue := self properties at: aKey put: aValue.
	
	self propertyAnnounceKey: aKey oldValue: anOldValue newValue: aNewValue.

	^ aNewValue
]

{ #category : #properties }
LuiProperties >> propertyAt: aSymbol putRemovingNil: aValue [
	
	| anOldValue |
	aValue ifNotNil: [ 
		^ self propertyAt: aSymbol put: aValue ].
	
	anOldValue := (self hasProperty: aSymbol)
		ifTrue: [ self properties removeKey: aSymbol ]
		ifFalse: [ aValue ].
		
	self propertyAnnounceKey: aSymbol oldValue: anOldValue newValue: aValue.
	
	^ anOldValue
]

{ #category : #subscription }
LuiProperties >> unsubscribe: aSubscriber [
	self properties
		at: #propertyAnnouncer
		ifPresent: [ :anAnnouncer | 
			anAnnouncer unsubscribe: aSubscriber ]
		ifAbsent: [  "ignore" ]
]

{ #category : #properties }
LuiProperties >> valueOfProperty: aName [
	^self propertyAt: aName ifPresent: [ :each | each value ] ifAbsent: [ nil ]
]

{ #category : #subscription }
LuiProperties >> whenPropertyChangedSend: aSelector to: aReceiver [
	| anAnnouncer |
	anAnnouncer := self properties 
		at: #propertyAnnouncer
		ifAbsentPut: [ Announcer new ].
		
	^ anAnnouncer weak 
		when: MAPropertyChangedAnnouncement
		send: aSelector
		to: aReceiver
]
