#ifndef UTIL_H
#define UTIL_H
/**
 * \file util.h
 * \brief utility functions
 */

#include <pthread.h>
#include <stdint.h>
#include <stdio.h>

/**
 * \brief append a path
 * \details This function appends a path with the next level, while taking the
 * trailing slash of the upper level into account.
 * \note You need to free the char * after use.
 */
char *path_append(const char *path, const char *filename);

/**
 * \brief division, but rounded to the nearest integer rather than truncating
 */
int64_t round_div(int64_t a, int64_t b);

/**
 * \brief wrapper for pthread_mutex_lock(), with error handling
 */
void PTHREAD_MUTEX_LOCK(pthread_mutex_t *x);

/**
 * \brief wrapper for pthread_mutex_unlock(), with error handling
 */
void PTHREAD_MUTEX_UNLOCK(pthread_mutex_t *x);

/**
 * \brief wrapper for exit(EXIT_FAILURE), with error handling
 */
void exit_failure(void);

/**
 * \brief erase a string from the terminal
 */
void erase_string(FILE *file, size_t max_len, char *s);

/**
 * \brief generate the salt for authentication string
 * \details this effectively generates a UUID string, which we use as the salt
 * \return a pointer to a 37-char array with the salt.
 */
char *generate_salt(void);

/**
 * \brief generate the md5sum of a string
 * \param[in] str a character array for the input string
 * \return a pointer to a 33-char array with the salt
 */
char *generate_md5sum(const char *str);

/**
 * \brief wrapper for calloc(), with error handling
 */
void *CALLOC(size_t nmemb, size_t size);

/**
 * \brief wrapper for free(), but the pointer is set to NULL afterwards.
 */
void FREE(void *ptr);

/**
 * \brief Convert a string to hex
 */
char *str_to_hex(char *s);

/**
 * \brief initialise the configuration data structure
 */
void Config_init(void);

#endif
