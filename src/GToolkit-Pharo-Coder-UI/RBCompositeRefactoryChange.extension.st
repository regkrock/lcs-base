Extension { #name : #RBCompositeRefactoryChange }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBCompositeRefactoryChange >> recursivelyRemoveChange: arg1 [
	self removeChange: arg1.
	changes do: [ :arg2 | arg2 recursivelyRemoveChange: arg1 ]
]
