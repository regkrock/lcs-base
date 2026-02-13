Class {
	#name : 'LcsDomainObjectSlotViewItem',
	#superclass : 'LcsViewItem',
	#category : 'Lcs-SystemManagement-View',
	#package : 'Lcs-SystemManagement',
	#tag : 'View'
}

{ #category : 'defaults' }
LcsDomainObjectSlotViewItem class >> defaultChildrenSelector [
	^ #domainObjectSlotViewItems
]

{ #category : 'children' }
LcsDomainObjectSlotViewItem >> itemChildrenForNonresponders [
	self item isString ifTrue: [ ^ #()].
	self item isCollection ifTrue: [ ^ self item collect: [ :each | LcsDomainObjectSlotViewItem newLabel: '' item: each ]].
	^ super itemChildrenForNonresponders
]
