

sealed class Resource<T> {
  const Resource();

  R when<R>({
    required R Function(T data) success,
    required R Function(String message) error,
    required R Function() loading,
  }) {
    if (this is Success<T>) {
      return success((this as Success<T>).data);
    } else if (this is Error) {
      return error((this as Error).message);
    } else if (this is Loading) {
      return loading();
    }
    throw Exception('Unhandled state: $this');
  }
}

class Success<T> extends Resource<T> {
  final T data;

  const Success(this.data);
}

class Error extends Resource<Never> {
  final String message;

  const Error(this.message);
}

class Loading extends Resource<Never> {
  const Loading();
}
