Class {
	#name : 'LcsDateRangeSlotBuilder',
	#superclass : 'LcsDomainObjectSlotBuilder',
	#instVars : [
		'exposeEffectiveDate',
		'exposeExpiryDate'
	],
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'configuration' }
LcsDateRangeSlotBuilder class >> slotClass [
	"Subclasses can override this method to provide a default"
	^ LcsDateRangeSlot
]

{ #category : 'job steps' }
LcsDateRangeSlotBuilder >> buildJobSteps [
	super buildJobSteps.
	self exposeEffectiveDate ifTrue: [ 
		self addJobStep: self effectiveDateFacadeBuilder ].
	self exposeExpiryDate ifTrue: [ 
		self addJobStep: self expiryDateFacadeBuilder ]
]

{ #category : 'job steps' }
LcsDateRangeSlotBuilder >> effectiveDateFacadeBuilder [
	| candidateSlotName |
	candidateSlotName := self slotName ifNil: [ '<undefined>' ].
	^ LcsDelegatorSlotBuilder new
		populateFrom: LcsDelegatorSlot name;
		slotName: candidateSlotName , 'EffectiveDate';
		targetClassName: self targetClassName;
		targetSlotPath: {candidateSlotName asSymbol.
				#effectiveDate} asOrderedCollection;
		slotTypes: (OrderedCollection with: Date);
		yourself
]

{ #category : 'job steps' }
LcsDateRangeSlotBuilder >> expiryDateFacadeBuilder [
	| candidateSlotName |
	candidateSlotName := self slotName ifNil: [ '<undefined>' ].
	^ LcsDelegatorSlotBuilder new
		populateFrom: LcsDelegatorSlot name;
		slotName: candidateSlotName , 'ExpiryDate';
		targetClassName: self targetClassName;
		targetSlotPath: {candidateSlotName asSymbol.
				#expiryDate} asOrderedCollection;
		slotTypes: (OrderedCollection with: Date);
		yourself
]

{ #category : 'accessing' }
LcsDateRangeSlotBuilder >> exposeEffectiveDate [
	^ exposeEffectiveDate
]

{ #category : 'accessing' }
LcsDateRangeSlotBuilder >> exposeEffectiveDate: anObject [
	exposeEffectiveDate := anObject
]

{ #category : 'margritte' }
LcsDateRangeSlotBuilder >> exposeEffectiveDateDescription [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Expose effective date';
		priority: 8;
		accessor: #exposeEffectiveDate;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : 'accessing' }
LcsDateRangeSlotBuilder >> exposeExpiryDate [
	^ exposeExpiryDate
]

{ #category : 'accessing' }
LcsDateRangeSlotBuilder >> exposeExpiryDate: anObject [
	exposeExpiryDate := anObject
]

{ #category : 'margritte' }
LcsDateRangeSlotBuilder >> exposeExpiryDateDescription [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Expose expiry date';
		priority: 8;
		accessor: #exposeExpiryDate;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : 'initialize' }
LcsDateRangeSlotBuilder >> initialize [
	super initialize.
	self slotTypes: (OrderedCollection with: LcsDateRange).
	self exposeEffectiveDate: true.
	self exposeExpiryDate: true
]
