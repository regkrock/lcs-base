Class {
	#name : #LcsUpdateSiblingFromCollectionDefaultAction,
	#superclass : #LcsUpdateAction,
	#instVars : [
		'siblingSlotName'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsUpdateSiblingFromCollectionDefaultAction >> defaultActionBlock [
	^ [ :newValue :domainObject :oldValue | 
			domainObject 
				perform: (self siblingSlotName , ':') asSymbol 
				with: (newValue defaultInstance) ]
]

{ #category : #accessing }
LcsUpdateSiblingFromCollectionDefaultAction >> siblingSlotName [
	^ siblingSlotName
]

{ #category : #accessing }
LcsUpdateSiblingFromCollectionDefaultAction >> siblingSlotName: aSlotName [
	siblingSlotName := aSlotName
]
