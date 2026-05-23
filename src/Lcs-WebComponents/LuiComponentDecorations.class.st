Class {
	#name : 'LuiComponentDecorations',
	#superclass : 'Object',
	#instVars : [
		'parentComponent',
		'collection'
	],
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LuiComponentDecorations class >> on: aComponent [
	^ self new 
		initializeOn: aComponent;
		yourself
]

{ #category : 'accessing' }
LuiComponentDecorations >> collection [
	^ collection
]

{ #category : 'accessing' }
LuiComponentDecorations >> collection: anObject [
	collection := anObject
]

{ #category : 'subscription' }
LuiComponentDecorations >> decorationAnnounceKey: aDecorationKey oldValue: anOldValue newValue: aNewValue [
	"Announce a property change if there are subscriptions."
	
	self decorationAnnouncerDo: [ :anAnnouncer |
		anOldValue = aNewValue ifFalse: [
			anAnnouncer announce: (MAPropertyChangedAnnouncement new
					owner: self;
					key: aDecorationKey;
					value: aNewValue) ] ]
]

{ #category : 'subscription' }
LuiComponentDecorations >> decorationAnnouncerDo: aBlock [
	"Announce a decoration change if there are subscriptions."

	self collection
		at: #decorationAnnouncer
		ifPresent: aBlock
		ifAbsent: [  "ignore" ]
]

{ #category : 'properties - accessing' }
LuiComponentDecorations >> decorationAt: aKey [
	"Answer the value of the property ==aKey==, raises an error if the property doesn't exist."

	^ self attributeAt: aKey ifAbsent: [ self errorAttributeNotFound: aKey ]
]

{ #category : 'properties - accessing' }
LuiComponentDecorations >> decorationAt: aKey ifAbsent: aBlock [
	"Answer the value of the attribute ==aKey==, or the result of ==aBlock== if the attribute doesn't exist."

	^ self collection at: aKey ifAbsent: aBlock
]

{ #category : 'properties - accessing' }
LuiComponentDecorations >> decorationAt: aKey ifAbsentPut: aBlock [
	"Answer the value of the attribute ==aKey==, or the result of ==aBlock== if the attribute doesn't exist."

	^ self collection at: aKey ifAbsentPut: aBlock
]

{ #category : 'properties - accessing' }
LuiComponentDecorations >> decorationAt: aKey ifPresent: aBlock [
	"Lookup the property ==aKey==, if it is present, answer the value of evaluating ==aBlock== block with the value. Otherwise, answer ==nil==."

	^ self collection at: aKey ifPresent: aBlock
]

{ #category : 'properties - accessing' }
LuiComponentDecorations >> decorationAt: aKey ifPresent: oneArgBlock ifAbsentPut: absentBlock [
	"Lookup ==aKey==, if it is present, answer the value of evaluating the oneArgBlock with the value associated with the key, otherwise answer the value of absentBlock."
	| anOldValue aNewValue |
	anOldValue := nil.
	aNewValue := self collection 
		at: aKey 
		ifPresent: [ :aValue | 
			anOldValue := aValue. 
			oneArgBlock value ]
		ifAbsentPut: absentBlock.
			
	self decorationAnnounceKey: aKey oldValue: anOldValue newValue: aNewValue.
	
	^ aNewValue
]

{ #category : 'properties - accessing' }
LuiComponentDecorations >> decorationAt: aKey put: aValue [
	"Adds or replaces the property ==aKey== with ==aValue==."

	| anOldValue aNewValue |
	anOldValue := self collection at: aKey ifAbsent: [ nil ].
	aNewValue := self collection at: aKey put: aValue.
	
	self decorationAnnounceKey: aKey oldValue: anOldValue newValue: aNewValue.

	^ aNewValue
]

{ #category : 'properties - accessing' }
LuiComponentDecorations >> decorationNamed: aName [
	^ self decorationAt: aName ifAbsent: [ ]
]

{ #category : 'gt view' }
LuiComponentDecorations >> decorationSearchOn: aSearch [
	<gtSearch>
	
	^ aSearch list
		title: 'Decorations';
		items: [ self collection associations ];
		previewObject: [ :assoc | assoc value ];
		filterBySubstring;
		send: [ :anObject | anObject value ]
]

{ #category : 'private' }
LuiComponentDecorations >> errorDecorationNotFound: aSelector [ 
	LuiComponentAttributeNotFound signal: 'Decoration ' , aSelector , ' not found.'
]

{ #category : 'gt view' }
LuiComponentDecorations >> gtViewDecorationsOn: aView [
	<gtView>
	
	self collection ifNil: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Decorations' translated;
		priority: 75;
		items: [ self collection associations ];
		column: 'Name' 
			text: [ :a | a key ]
			width: 75;
		column: 'Decoration' text: [ :anAssociation | anAssociation value class name displayString ];
		column: 'Cached' text: [ :anAssociation | anAssociation value cachedValue displayString ];
		column: 'Basic Value' text: [ :anAssociation | anAssociation value _decorationValue displayString ];
		column: 'Block' text: [ :anAssociation | anAssociation value  valueBlock displayString];
		send: [ :e | e value ];
		actionUpdateButton
]

{ #category : 'properties - testing' }
LuiComponentDecorations >> hasDecorationNamed: aString [
	^ (self decorationAt:  aString ifAbsent: [ nil ]) notNil
]

{ #category : 'properties - testing' }
LuiComponentDecorations >> hasDecorations [
	^ self collection notEmpty
]

{ #category : 'properties - testing' }
LuiComponentDecorations >> hasNoDecorations [
	^ self collection isEmpty
]

{ #category : 'decoration' }
LuiComponentDecorations >> hasNoTextDecoration [
	^ self hasTextDecoration not
]

{ #category : 'decoration' }
LuiComponentDecorations >> hasTextDecoration [
	^ self hasDecorationNamed: LuiTextDecoration decorationName
]

{ #category : 'initialize' }
LuiComponentDecorations >> initialize [
	super initialize.
	self collection: Dictionary new
]

{ #category : 'initialize' }
LuiComponentDecorations >> initializeOn: aComponent [
	self parentComponent: aComponent
]

{ #category : 'properties - delegated' }
LuiComponentDecorations >> isNotRenderable [
	self hasRenderingAttribute ifFalse: [ ^ false ].
	^ self renderingAttribute isNotRenderable 
]

{ #category : 'properties - accessing' }
LuiComponentDecorations >> lazyInitializedDecoration: aDecorationClass [
	^ self decorationAt: aDecorationClass decorationName ifAbsentPut: [ aDecorationClass on: self ]
]

{ #category : 'accessing' }
LuiComponentDecorations >> parentComponent [
	^ parentComponent
]

{ #category : 'accessing' }
LuiComponentDecorations >> parentComponent: anObject [
	parentComponent := anObject
]

{ #category : 'copying' }
LuiComponentDecorations >> postCopyProperties [
	"Call after super postCopy"
	collection := collection copy
]

{ #category : 'properties - testing' }
LuiComponentDecorations >> text [
	^ self textDecoration text
]

{ #category : 'properties - testing' }
LuiComponentDecorations >> text: aString [
	self textDecoration text: aString
]

{ #category : 'decoration' }
LuiComponentDecorations >> textDecoration [
	^ self lazyInitializedDecoration: LuiTextDecoration
]

{ #category : 'subscription' }
LuiComponentDecorations >> unsubscribe: aSubscriber [
	self collection
		at: #decorationAnnouncer
		ifPresent: [ :anAnnouncer | 
			anAnnouncer unsubscribe: aSubscriber ]
		ifAbsent: [  "ignore" ]
]

{ #category : 'properties - delegated' }
LuiComponentDecorations >> valueOfDecoration: aDecorationName [
	(self hasDecorationNamed: aDecorationName) ifFalse: [ ^ nil ].
	^ (self decorationAt: aDecorationName) attributeValue
]

{ #category : 'subscription' }
LuiComponentDecorations >> whenDecorationChangedSend: aSelector to: aReceiver [
	| anAnnouncer |
	anAnnouncer := self collection 
		at: #decorationAnnouncer
		ifAbsentPut: [ Announcer new ].
		
	^ anAnnouncer weak 
		when: MAPropertyChangedAnnouncement
		send: aSelector
		to: aReceiver
]
