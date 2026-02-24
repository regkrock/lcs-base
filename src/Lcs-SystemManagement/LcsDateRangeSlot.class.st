Class {
	#name : 'LcsDateRangeSlot',
	#superclass : 'LcsDomainObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsDateRangeSlot >> defaultEffectiveDate [
	^ Date
		newDay: 1
		month: 1
		year: 1970
]

{ #category : 'defaults' }
LcsDateRangeSlot >> defaultExpiryDate [
	^ Date
		newDay: 31
		month: 12
		year: 2100
]

{ #category : 'accessing' }
LcsDateRangeSlot >> effectiveDate [
	^ self propertyAt: 'effectiveDate' ifAbsent: [ self defaultEffectiveDate ]
]

{ #category : 'accessing' }
LcsDateRangeSlot >> effectiveDate: aDate [ 
	self propertyAt: 'initialEffectiveDate' put: aDate
]

{ #category : 'margritte' }
LcsDateRangeSlot >> effectiveDateDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Effective Date';
		priority: 8.3;
		accessor:(MAPluggableAccessor
						read: [ :aModel | aModel effectiveDate yyyymmdd ]
						write: [ :aModel :aValue | aModel effectiveDate: (Date fromString: aValue) ]);
		kind: String;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : 'accessing' }
LcsDateRangeSlot >> expiryDate [
	^ self propertyAt: 'expiryDate' ifAbsent: [ self defaultExpiryDate ]
]

{ #category : 'accessing' }
LcsDateRangeSlot >> expiryDate: aDate [ 
	self propertyAt: 'expiryDate' put: aDate
]

{ #category : 'margritte' }
LcsDateRangeSlot >> expiryDateDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Initial Expiry Date';
		priority: 8.3;
		accessor:(MAPluggableAccessor
						read: [ :aModel | aModel expiryDate yyyymmdd ]
						write: [ :aModel :aValue | aModel expiryDate: (Date fromString: aValue) ]);
		kind: String;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : 'initialize' }
LcsDateRangeSlot >> initialize [
	super initialize.
	self addSlotType: LcsDateRange.
	self effectiveDate: self defaultEffectiveDate.
	self expiryDate: self defaultExpiryDate
]

{ #category : 'defaults' }
LcsDateRangeSlot >> newInstanceOfFirstSlotTypeIn: slot parent: parentDomainObject [
	^ (super newInstanceOfFirstSlotTypeIn: slot parent: parentDomainObject)
		effectiveDate: self effectiveDate;
		expiryDate: self expiryDate;
		yourself
]

{ #category : 'as yet unclassified' }
LcsDateRangeSlot >> test [
	^ 'abc'
]

{ #category : 'margritte' }
LcsDateRangeSlot >> testStringDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'TEST';
		priority: 8.3;
		accessor: #test;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]
