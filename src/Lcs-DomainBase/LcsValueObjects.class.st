Class {
	#name : 'LcsValueObjects',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-DomainBase-Core',
	#package : 'Lcs-DomainBase',
	#tag : 'Core'
}

{ #category : 'testing' }
LcsValueObjects >> defaultInstance [
	^ self
		find: [ :each | each isDefaultInstance == true ]
		ifNone: [ LcsCodeCollectionDefaultInstanceNotDefined
				signal: 'No default instance defined for Value Objects collection - ' , self class name ]
]

{ #category : 'querying' }
LcsValueObjects >> findItemMatchingCode: aCode [
	^ self findItemMatchingCode: aCode ifNone: [ nil ]
]

{ #category : 'querying' }
LcsValueObjects >> findItemMatchingCode: aCode ifNone: aBlock [
	^ self find: [ :each | each code = aCode ] ifNone: aBlock 
]

{ #category : 'gt views' }
LcsValueObjects >> gtItemsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Items' translated;
		priority: 0.5;
		items: [ (self collection ifNil: [ OrderedCollection new] ) asOrderedCollection ];
		column: 'code' text: [ :each | each code ];
		column: 'description' text: [ :each | each description ];
		column: 'Label' text: [ :each | each label ];
		column: 'Is Default' text: [ :each | each isDefaultInstance ifTrue: [ 'Yes' ] ifFalse: [ '' ] ];
		actionUpdateButton
]

{ #category : 'testing' }
LcsValueObjects >> hasDefaultInstance [
	self find: [ :each | each isDefaultInstance == true ] ifNone: [ ^ false ].
	^ true
]
