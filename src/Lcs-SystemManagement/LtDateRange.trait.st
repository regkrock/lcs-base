Trait {
	#name : 'LtDateRange',
	#instVars : [
		'dateRange'
	],
	#category : 'Lcs-SystemManagement-Traits',
	#package : 'Lcs-SystemManagement',
	#tag : 'Traits'
}

{ #category : 'slot definitions' }
LtDateRange classSide >> dateRangeSlotDefinition [
	<accessorSlotDefinition>
	^ LcsDateRangeSlot new
		slotName: 'dateRange';
		yourself
]

{ #category : 'accessing' }
LtDateRange >> dateRange [
	^ self slotVarNamed: 'dateRange'
]

{ #category : 'accessing' }
LtDateRange >> dateRange: anObject [
	self slotVarNamed: 'dateRange' put: anObject
]
