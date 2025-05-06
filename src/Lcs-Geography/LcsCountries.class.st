Class {
	#name : #LcsCountries,
	#superclass : #LcsDomainCollection,
	#category : #'Lcs-Geography'
}

{ #category : #'gt views' }
LcsCountries >> gtItemsFor: aView [
	<gtView>
	self collection isNil ifTrue: [ ^ aView empty ].
	^ aView columnedList
		title: 'Items' translated;
		priority: 0.5;
		items: [ self collection asOrderedCollection ];
		column: 'Code' translated text: [ :each | each isoCode ] width: 30;
		column: 'Name' translated text: [ :each | each commonName ];
		"view: #gtItemsFor:;"
		actionUpdateButton
]
