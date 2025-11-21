Class {
	#name : 'GtLepiterWorkingCopyChangesUseIndexStrategy',
	#superclass : 'GtLepiterWorkingCopyChangesStrategy',
	#category : 'GToolkit4Git-Lepiter',
	#package : 'GToolkit4Git',
	#tag : 'Lepiter'
}

{ #category : 'API - changes' }
GtLepiterWorkingCopyChangesUseIndexStrategy >> changesTo: aCommitish [
	^ self workingCopy changesToHeadUsingIndex
]
