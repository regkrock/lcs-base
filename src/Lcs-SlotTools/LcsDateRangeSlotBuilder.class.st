Class {
	#name : 'LcsDateRangeSlotBuilder',
	#superclass : 'LcsDomainObjectSlotBuilder',
	#instVars : [
		'exposeEffectiveDate',
		'exposeExpiryDate',
		'effectiveDate',
		'expiryDate'
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

{ #category : 'defaults' }
LcsDateRangeSlotBuilder >> defaultEffectiveDate [
	^ Date newDay: 01 month: 01 year: 1970
]

{ #category : 'defaults' }
LcsDateRangeSlotBuilder >> defaultExpiryDate [
	^ Date newDay: 31 month: 12 year: 2100
]

{ #category : 'accessing' }
LcsDateRangeSlotBuilder >> effectiveDate [
	^ self propertyAt: 'effectiveDate' ifAbsentPut: self defaultEffectiveDate
]

{ #category : 'accessing' }
LcsDateRangeSlotBuilder >> effectiveDate: anObject [
	self propertyAt: 'effectiveDate' put: anObject
]

{ #category : 'margritte' }
LcsDateRangeSlotBuilder >> effectiveDateDescription [
	^ MAStringDescription new
		label: 'Effective date';
		priority: 8;
		accessor:(LcsMAPluggableAccessor
						accessors: #(#effectiveDate)
						read: [ :aModel | aModel yyyymmdd ]
						write: [ :aModel :setter :dateString | aModel perform: setter with: (Date fromString: dateString) ]);
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
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

{ #category : 'accessing' }
LcsDateRangeSlotBuilder >> expiryDate [
	^ self propertyAt: 'expiryDate' ifAbsentPut: self defaultExpiryDate
]

{ #category : 'accessing' }
LcsDateRangeSlotBuilder >> expiryDate: anObject [
	self propertyAt: 'expiryDate' put: anObject
]

{ #category : 'margritte' }
LcsDateRangeSlotBuilder >> expiryDateDescription [
	<magritteDescription>
	| description |
	description :=  MAStringDescription new
		label: 'Expiry Date';
		priority: 8.3;
		accessor:(LcsMAPluggableAccessor
						accessors: #(#expiryDate)
						read: [ :aModel | aModel yyyymmdd ]
						write: [ :aModel :setter :dateString | aModel perform: setter with: (Date fromString: dateString) ]);
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		yourself.
	^ description "inspect"
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
		priority: 8.2;
		accessor: #exposeExpiryDate;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : 'initialize' }
LcsDateRangeSlotBuilder >> initialize [
	super initialize.
	self slotTypes: (OrderedCollection with: LcsDateRange).
	self exposeEffectiveDate: true.
	self effectiveDate: self defaultEffectiveDate.
	self exposeExpiryDate: true.
	self expiryDate: self defaultExpiryDate
]
