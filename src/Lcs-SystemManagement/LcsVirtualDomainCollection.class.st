Class {
	#name : 'LcsVirtualDomainCollection',
	#superclass : 'LcsBaseDomainCollection',
	#category : 'Lcs-SystemManagement-Domain',
	#package : 'Lcs-SystemManagement',
	#tag : 'Domain'
}

{ #category : 'configuration' }
LcsVirtualDomainCollection class >> collectionType [
	^'virtual'
]

{ #category : 'gt views' }
LcsVirtualDomainCollection >> gtItemsFor: aView [
	<gtView>
	| columnedListView |
	columnedListView := 
		aView columnedList
			title: 'Items' translated;
			priority: 0.5;
			items: [ self collection asOrderedCollection ];
			actionUpdateButton.
	self collection notEmpty ifTrue: [
		self collection any collectionViewSlotDefinitions do: [ :eachSlotDefinition |
			columnedListView 
				column: eachSlotDefinition label 
				text: [:domainObject | (domainObject perform: eachSlotDefinition getterSelector) asString ] 
				width: 100 ] ].
	^ columnedListView
]
