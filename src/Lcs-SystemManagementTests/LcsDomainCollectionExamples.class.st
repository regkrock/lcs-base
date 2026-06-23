Class {
	#name : 'LcsDomainCollectionExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SystemManagementTests-Examples',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Examples'
}

{ #category : 'as yet unclassified' }
LcsDomainCollectionExamples >> newCollection [
	<gtExample>
	| domainCollection |
	self ensureCurrentSystemIsPrototypeSystem.
	domainCollection := LcsDomainCollection new.
	self assert: domainCollection collectionSize equals: 0.
	self assert: domainCollection currentSize equals: 0.
	self assert: domainCollection collection isEmpty.
	self assert: domainCollection isEmpty.
	self assert: domainCollection hasNoElements.
	self deny: domainCollection hasElements.
	self assert: domainCollection pendingAdds isEmpty.
	self assert: domainCollection pendingDeletes isEmpty.
	self deny: domainCollection hasPendingAdds.
	self deny: domainCollection hasPendingDeletes.
	self assert: domainCollection gtDisplayString equals: 'a LcsDomainCollection [0 items] ()'.
	self assert: (domainCollection findWithKey: 'asdf') isNil.
	^ domainCollection
]

{ #category : 'as yet unclassified' }
LcsDomainCollectionExamples >> sortedItems [
	<gtExample>
	| domainCollection nonsortedItemsCollection sortedItemsCollection|
	self ensureCurrentSystemIsPrototypeSystem.
	domainCollection := self currentSystem skills.
	self assert: domainCollection collectionSize equals: 4.
	nonsortedItemsCollection := domainCollection collection asArray.
	sortedItemsCollection := domainCollection sorted: [ :a :b | a skillName < b skillName ].
	self assert: sortedItemsCollection class equals: SortedCollection.
	self deny: nonsortedItemsCollection first = sortedItemsCollection first.
	^ sortedItemsCollection
]
