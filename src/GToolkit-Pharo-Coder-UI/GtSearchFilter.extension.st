Extension { #name : #GtSearchFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchFilter class >> filterDescriptorFor: arg1 [
	^ self globalFilterDescriptor
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchFilter >> filterDescriptorFor: arg1 [
	^ self class filterDescriptorFor: arg1
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchFilter class >> globalFilterDescriptor [
	^ nil
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchFilter class >> globalFilterDescriptors [
	| tmp1 tmp2 tmp3 |
	tmp1 := OrderedCollection new.
	tmp2 := GtSearchFilter allSearchFilters
			asSortedCollection: [ :arg1 :arg2 | arg1 filterLabel < arg2 filterLabel ].
	tmp2
		do: [ :arg3 | 
			| tmp4 tmp6 |
			tmp6 := GtFilterDescriptor new.
			tmp6
				valueNotRequired;
				creator: [ :arg4 | arg3 ];
				named: arg3 filterLabel.
			tmp4 := tmp6 order: tmp1 size / tmp2 size.
			arg3 = GtSearchImageMethodsFilter forAllMethods
				ifFalse: [ tmp4 beNotDefault ].
			tmp1 add: tmp4 ].
	tmp3 := ((self withAllSubclasses collect: #globalFilterDescriptor)
			select: #notNil)
			asSortedCollection: [ :arg5 :arg6 | arg5 order < arg6 order ].
	tmp3 do: #beNotDefault.
	tmp1 addAll: tmp3.
	^ tmp1
]
