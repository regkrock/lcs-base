Class {
	#name : 'LcsValueObjects',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-DomainBase-Core',
	#package : 'Lcs-DomainBase',
	#tag : 'Core'
}

{ #category : 'testing' }
LcsValueObjects >> collectionWithPendingChanges [
	| actualCollection |
	actualCollection := self collection copy.
	actualCollection addAll: self pendingAdds.
	actualCollection removeAll: self pendingDeletes.
	^ actualCollection
]

{ #category : 'testing' }
LcsValueObjects >> defaultInstance [
	^ self collectionWithPendingChanges
		detect: [ :each | each isDefaultInstance == true ]
		ifNone: [ LcsCodeCollectionDefaultInstanceNotDefined
				signal: 'No default instance defined for Value Objects collection - ' , self class name ]
]

{ #category : 'querying' }
LcsValueObjects >> findItemMatchingCode: anObject [
	| result |
	anObject isString ifFalse: [ ^ anObject ].
	result := self collection detect: [ :each | each code = anObject ] ifNone: [ nil ].
	result ifNotNil: [ ^ result ].
	^ self pendingAdds detect: [ :each | each code = anObject ] ifNone: [ anObject ].
]

{ #category : 'gt views' }
LcsValueObjects >> gtItemsFor: aView [
	<gtView>
	self collection isNil ifTrue: [ ^ aView empty ].
	^ aView columnedList
		title: 'Items' translated;
		priority: 0.5;
		items: [ self collection asOrderedCollection ];
		column: 'code' text: [ :each | each code ];
		column: 'description' text: [ :each | each description ];
		column: 'Label' text: [ :each | each label ];
		column: 'Is Default' text: [ :each | each isDefaultInstance ifTrue: [ 'Yes' ] ifFalse: [ '' ] ];
		actionUpdateButton
]

{ #category : 'testing' }
LcsValueObjects >> hasDefaultInstance [
	self collection detect: [ :each | each isDefaultInstance == true] ifNone: [ ^ false ].
	^ true
]
