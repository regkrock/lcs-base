Class {
	#name : 'LcsLogger',
	#superclass : 'LcsObject',
	#instVars : [
		'tabLevel',
		'stream'
	],
	#classInstVars : [
		'soleInstance'
	],
	#category : 'LcsBase-Core',
	#package : 'LcsBase',
	#tag : 'Core'
}

{ #category : 'logging' }
LcsLogger class >> cr [
	self soleInstance cr
]

{ #category : 'logging' }
LcsLogger class >> decrementTabLevel [
	self soleInstance decrementTabLevel
]

{ #category : 'logging' }
LcsLogger class >> incrementTabLevel [
	self soleInstance incrementTabLevel
]

{ #category : 'logging' }
LcsLogger class >> indent [
	self soleInstance incrementTabLevel
]

{ #category : 'logging' }
LcsLogger class >> log: aMessage [
	self soleInstance log: aMessage
]

{ #category : 'logging - api' }
LcsLogger class >> logGettingInitialValue [
	self soleInstance logGettingInitialValue
]

{ #category : 'logging' }
LcsLogger class >> logIndented: aMessage [
	self soleInstance logIndented: aMessage
]

{ #category : 'logging - api' }
LcsLogger class >> logReceiver: aReceiver message: aMessage [
	self soleInstance logReceiver: aReceiver message: aMessage
]

{ #category : 'logging - api' }
LcsLogger class >> logReceiver: aReceiver slector: aSelector arguments: aCollection [
	self soleInstance logReceiver: aReceiver slector: aSelector arguments: aCollection
]

{ #category : 'logging - api' }
LcsLogger class >> logReturningInitialValue: anObject [
	self soleInstance logReturningInitialValue: anObject
]

{ #category : 'logging' }
LcsLogger class >> logTab: aMessage [
	self soleInstance logTab: aMessage
]

{ #category : 'configuration' }
LcsLogger class >> loggingOff [
	self soleInstance loggingOff
]

{ #category : 'logging' }
LcsLogger class >> outdent [
	self soleInstance decrementTabLevel
]

{ #category : 'command' }
LcsLogger class >> reset [
	self soleInstance reset
]

{ #category : 'accessing' }
LcsLogger class >> soleInstance [
	^ soleInstance ifNil: [ soleInstance := self new ]
]

{ #category : 'accessing' }
LcsLogger class >> soleInstance: anObject [
	soleInstance := anObject
]

{ #category : 'configuration' }
LcsLogger class >> streamLoggingOn [
	self soleInstance streamLoggingOn
]

{ #category : 'configuration' }
LcsLogger class >> transcriptLoggingOn [
	self soleInstance transcriptLoggingOn
]

{ #category : 'logging' }
LcsLogger >> cr [
	^ self stream cr
]

{ #category : 'tabs' }
LcsLogger >> decrementTabLevel [
	self tabLevel > 0 ifTrue: [
		self tabLevel: self tabLevel - 1 ].
]

{ #category : 'tabs' }
LcsLogger >> incrementTabLevel [
	self tabLevel: self tabLevel + 1
]

{ #category : 'tabs' }
LcsLogger >> indent [
	self incrementTabLevel
]

{ #category : 'initialize' }
LcsLogger >> initialize [
	super initialize.
	self tabLevel: 0.
	self stream: NullStream new
]

{ #category : 'logging' }
LcsLogger >> log: aMessage [
	self writeTabs.
	self nextPutAll: aMessage.
	self cr
]

{ #category : 'logging - api' }
LcsLogger >> logGettingInitialValue [
	self 
		indent; 
		log: 'Getting initial value';
		indent
]

{ #category : 'logging' }
LcsLogger >> logIndented: aMessage [
	self writeTabs.
	self tab.
	self nextPutAll: aMessage.
	self cr
]

{ #category : 'logging - api' }
LcsLogger >> logReceiver: aReceiver message: aMessage [
	self 
		writeTabs;
		nextPutAll:aReceiver printString , '>>' , aMessage printString;
		cr 
]

{ #category : 'logging - api' }
LcsLogger >> logReceiver: aReceiver slector: aSelector arguments: aCollection [
	self 
		writeTabs;
		nextPutAll:aReceiver printString , '>>' , aSelector.
		aCollection doWithIndex: [ :each :index | 
				self nextPutAll: ' arg' , index asString , ': ' , each printString ] 
]

{ #category : 'logging - api' }
LcsLogger >> logReturningInitialValue: anObject [
	self 
		outdent;
		log: 'Returning initialValue of: ', anObject printString;
		outdent.
]

{ #category : 'logging' }
LcsLogger >> logTab: aMessage [
	self writeTabs.
	self tab.
	self stream nextPutAll: aMessage asString.
	self cr
]

{ #category : 'configuration' }
LcsLogger >> loggingOff [
	self stream: NullStream new.
]

{ #category : 'logging' }
LcsLogger >> nextPutAll: aMessage [
	self stream nextPutAll: aMessage asString
]

{ #category : 'tabs' }
LcsLogger >> outdent [
	self decrementTabLevel
]

{ #category : 'command' }
LcsLogger >> reset [
	self stream isStream
		ifTrue: [self stream reset]
		ifFalse: [ [ self stream clear ] on: BlTextOutOfBoundsError do: [ :s | s return: self ] ].
	self tabLevel: 0.
]

{ #category : 'accessing' }
LcsLogger >> stream [
	^ stream
]

{ #category : 'accessing' }
LcsLogger >> stream: anObject [
	stream := anObject
]

{ #category : 'configuration' }
LcsLogger >> streamLoggingOn [
	self stream: (WriteStream on: String new)
]

{ #category : 'logging' }
LcsLogger >> tab [
	^ self stream tab
]

{ #category : 'accessing' }
LcsLogger >> tabLevel [
	^ tabLevel
]

{ #category : 'accessing' }
LcsLogger >> tabLevel: anObject [
	tabLevel := anObject
]

{ #category : 'configuration' }
LcsLogger >> transcriptLoggingOn [
	self stream: Transcript.
]

{ #category : 'logging' }
LcsLogger >> writeTabs [
	self tabLevel timesRepeat: [ self tab ]
]
